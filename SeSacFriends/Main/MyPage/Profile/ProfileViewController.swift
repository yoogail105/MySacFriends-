//
//  ProfileDetailViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/28.
//

import UIKit
import SwiftUI
import RxCocoa
import RxSwift

class ProfileViewController: BaseViewController {
    
    var withdrawalCoordinator: WithdrawalCoordinator?

    let mainView = ProfileView()
    lazy var withdrawalAlert = AlertView()
    
    let viewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    
    var userTitles: [String] = []
    var sectionTitles: [String] = []
    
    let rageSlider = RangeSlider()
    
    var ageMin = 18 {
        didSet {
           changeAgeValue()
        }
    }
    
    var ageMax = 65 {
        didSet {
            changeAgeValue()
        }
    }
    
    override func loadView() {
        print(#function)
        self.view = self.mainView
        
        
        let time = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: time + 0.1) {
            self.mainView.detailView.ageBar.trackHighlightTintColor = UIColor.brandColor(.green)
            self.mainView.detailView.ageBar.thumbImage = UIImage(named: AssetIcon.filterControl.rawValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        getProfileData()
    // MARK:coordinator
        withdrawalCoordinator = WithdrawalCoordinator(navigationController: self.navigationController!, parentCoordinator: coordinator)
        self.title = TabBarTitle.detail.rawValue
        
        for userTitle in UserTitleText.allCases {
            userTitles.append(userTitle.rawValue)
        }
        
        for sectionTitle in ProfileCardTableViewSectionHeaderText.allCases {
            sectionTitles.append(sectionTitle.rawValue)
        }

        
        let tableView = mainView.cardView.tableView
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.identifier)
        tableView.register(ProfileCardTitleTableViewCell.self, forCellReuseIdentifier: ProfileCardTitleTableViewCell.identifier)
        tableView.register(ProfileCardReviewTableViewCell.self, forCellReuseIdentifier: ProfileCardReviewTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.estimatedRowHeight = 58
        tableView.separatorStyle = .none
    
    }
    
    func setUpDetailView() {
        print("setUpDetailView")
        let profileData = viewModel.profileData
        let detailView = mainView.detailView
    
        switch profileData.gender {
        
        case 0:
            print(profileData.gender)
            detailView.womanButton.buttonModeColor(.fill)
            detailView.manButton.buttonModeColor(.inactive)
        case 1:
            print(profileData.gender)
            detailView.womanButton.buttonModeColor(.inactive)
            detailView.manButton.buttonModeColor(.fill)
        default:
            print(profileData.gender)
            detailView.womanButton.buttonModeColor(.inactive)
            detailView.manButton.buttonModeColor(.inactive)
        }
        
        detailView.hobbyTextField.text = profileData.hobby
        
        if profileData.searchable == 1 {
            detailView.searchableSwitch.isOn = true
        } else {
            detailView.searchableSwitch.isOn = false
        }
        print("lowerValue: \(RangeSlider().lowerValue), upperValeu: \(RangeSlider().upperValue)")
        print("upperValue: \(viewModel.profileData.ageMax  - 18)")
        detailView.ageLabelSub.text = "\(profileData.ageMin)-\(profileData.ageMax)"
        
        detailView.ageBar.lowerValue = CGFloat(viewModel.profileData.ageMin) - 18
        detailView.ageBar.upperValue = CGFloat(viewModel.profileData.ageMax) - 18
        
    }
    
    func getProfileData() {
        print("정보가져오기")
        
        viewModel.onErrorHandling = { result in
            if result == .ok {
                self.setUpDetailView()
            }
            
        }
        self.viewModel.getUser()
    }
  
    
    override func bind() {
        
        let detailView = mainView.detailView
      
        // MARK: genderButton
        let womanButton = mainView.detailView.womanButton
        let manButton = mainView.detailView.manButton
        let genderButtons = [womanButton, manButton]
        
      
        viewModel.genderObserver
            .map { $0 == 0 ? CustomButton.fill : CustomButton.inactive }
            .subscribe(onNext: { mode in
                womanButton.buttonModeColor(mode)
            })
            .disposed(by: disposeBag)
        
        viewModel.genderObserver
            .map { $0 == 1 ? CustomButton.fill : CustomButton.inactive }
            .subscribe(onNext: { mode in
                manButton.buttonModeColor(mode)
                
            })
            .disposed(by: disposeBag)
        
        var gender = viewModel.profileData.gender
        
        womanButton.rx.tap
            .scan(gender) { lastSelected, _ in
                switch lastSelected {
                case 0:
                    if womanButton.backgroundColor == UIColor.white {
                        return 0
                    }
                    return -1
                case 1:
                    return 0
                default:
                    return 0
                }
            }
            .bind(to: viewModel.genderObserver)
            .disposed(by: disposeBag)
        
        manButton.rx.tap
            .scan(gender) { lastSelected, _ in
                switch lastSelected {
                case 0:
                    return 1
                case 1:
                    if manButton.backgroundColor == UIColor.white {
                        return 1
                    }
                    return -1
                default:
                    return 1
                }
            }
            .bind(to: viewModel.genderObserver)
            .disposed(by: disposeBag)
        
        // MARK: hobby
        detailView.hobbyTextField.rx.text
            .orEmpty
            .bind(to: viewModel.hobbyObserer)
            .disposed(by: disposeBag)
    
        // MARK: searchable
        mainView.detailView.searchableSwitch.rx.isOn
            .map { $0 ? 1 : 0 }
            .bind(to: viewModel.searchableObserver)
            .disposed(by: disposeBag)
    
      
        // MARK: sliderBar 수정 필요!
        
        
        // withdawbutton 
        mainView.detailView.withdrawalButton.rx.tap
            .subscribe(onNext: { _ in
                self.withdrawal()
            })
            .disposed(by: disposeBag)
    }
    
    func changeAgeValue() {
        mainView.detailView.ageLabelSub.text = "\(ageMin)-\(ageMax)"
    }
    
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        let saveButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(saveButtonClicked))
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }
    
    override func back() {
        showToastWithAction(message: ProfileViewText.backButtonClicked.rawValue) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func saveButtonClicked() {
        
        viewModel.updateMypage() {_ in
            self.showToast(message: ProfileViewText.saveButtonClicked.rawValue)
        }
        //api 보내기
       
    }
    
    
    override func addAction() {

        mainView.detailView.ageBar.addTarget(self, action: #selector(rangeSliderValueChanged(_:)),
                                  for: .valueChanged)
        
        
    }
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
      let values = "(\(rangeSlider.lowerValue) \(rangeSlider.upperValue))"
        ageMin = Int(rangeSlider.lowerValue) + 18
        ageMax = Int(rangeSlider.upperValue) + 18
        viewModel.profileData.ageMin = ageMin
        viewModel.profileData.ageMax = ageMax
        
      print("Range slider value changed: \(values)")
        print("profiledata change: \(viewModel.profileData.ageMin),\(viewModel.profileData.ageMax)")
    }

    
    func withdrawal() {
        print(#function)
        

        let vc = withdrawalViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
       
    }
}


// MARK: TableView
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        default:
            return sectionTitles[section - 1]
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont().Title6_R12
        header.textLabel?.textColor = UIColor.black
        
        if section == 2 {
            let moreButton = UIButton()
            moreButton.setImage(UIImage(named: AssetIcon.moreArrow.rawValue), for: .normal)
            header.addSubview(moreButton)
            moreButton.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().offset(-16)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 18
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath)
        switch indexPath {
        case [0, 0]:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NameTableViewCell.identifier, for: indexPath) as? NameTableViewCell else { return UITableViewCell()}
            cell.label.text = userDefaults.nickname
            cell.selectionStyle = .none
            return cell
        case [1, 0]:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCardTitleTableViewCell.identifier, for: indexPath) as? ProfileCardTitleTableViewCell else { return UITableViewCell()}
            cell.selectionStyle = .none
            return cell
        case [2, 0]:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCardReviewTableViewCell.identifier, for: indexPath) as? ProfileCardReviewTableViewCell else { return UITableViewCell()}
            //cell.backgroundColor = .yellow
            cell.selectionStyle = .none
        
            return cell
            
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case [1,0]:
            return CGFloat(32 * (userTitles.count / 2) + 24)
        default:
            return UITableView.automaticDimension
        }
    }
}


//struct ProfileDetailViewControllerPreview: PreviewProvider {
//    static var previews: some View {
//        Container().edgesIgnoringSafeArea(.all)
//    }
//
//    struct Container: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> UIViewController {
//            let controller = ProfileViewController()
//            return UINavigationController(rootViewController: controller)
//        }
//
//
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
//
//        typealias UIViewControllerType = UIViewController
//    }
//}
