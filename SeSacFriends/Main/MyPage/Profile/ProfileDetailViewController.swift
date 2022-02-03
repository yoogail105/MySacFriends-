//
//  ProfileDetailViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/28.
//

import UIKit
import SwiftUI

class ProfileDetailViewController: BaseViewController, UIScrollViewDelegate {
    
    
    
    //let mainView = ProfileView()
    
    let cardView = ProfileCardView()
    let detailView = ProfileDetailView()
    
    var userTitles: [String] = []
    var sectionTitles: [String] = []
    
    let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .yellow
        $0.showsVerticalScrollIndicator = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    let contentView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .red
    }
    
//    override func loadView() {
//        //self.view = mainView
//
//        //mainView.scrollView.delegate = self
//        let time = DispatchTime.now()
//        DispatchQueue.main.asyncAfter(deadline: time) {
//            self.detailView.ageBar.trackHighlightTintColor = UIColor.brandColor(.green)
//            self.detailView.ageBar.thumbImage = UIImage(named: AssetIcon.filterControl.rawValue)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = TabBarTitle.detail.rawValue
        
        for userTitle in UserTitleText.allCases {
            userTitles.append(userTitle.rawValue)
        }
        
        for sectionTitle in ProfileCardTableViewSectionHeaderText.allCases {
            sectionTitles.append(sectionTitle.rawValue)
        }
        
        let tableView = cardView.tableView
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.identifier)
        tableView.register(ProfileCardTitleTableViewCell.self, forCellReuseIdentifier: ProfileCardTitleTableViewCell.identifier)
        tableView.register(ProfileCardReviewTableViewCell.self, forCellReuseIdentifier: ProfileCardReviewTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.estimatedRowHeight = 58
        tableView.separatorStyle = .none
        
        constraints()
    
    }
    
    func constraints() {
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        
        [cardView, detailView].forEach {
            contentView.addSubview($0)
            
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
//            $0.height.equalToSuperview()
          //  $0.centerX.equalToSuperview()
//            $0.width.equalToSuperview()
        }

        contentView.snp.makeConstraints {
          //  $0.top.equalToSuperview()
            $0.edges.equalToSuperview()
           // $0.centerX.equalToSuperview()
           // $0.trailing.leading.equalToSuperview()
           //$0.width.equalToSuperview()
        }
//
    
        cardView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
          //  $0.width.equalToSuperview()
            $0.height.equalTo(500)
            //$0.centerX.equalToSuperview()
        }
        


        detailView.snp.makeConstraints {
            $0.top.equalTo(cardView.snp.bottom).offset(8)
            $0.trailing.leading.bottom.equalToSuperview()
//            $0.bottom.equalTo(contentView.snp.bottom)
          //  $0.width.equalToSuperview()
            $0.height.equalTo(350)
            
            
        }
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        let saveButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(saveButtonClicked))
        
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
    }
    
    @objc func saveButtonClicked() {
        
    }
    
    override func addAction() {
        detailView.ageBar.addTarget(self, action: #selector(rangeSliderValueChanged(_:)),
                                  for: .valueChanged)
        
        
    }
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
      let values = "(\(rangeSlider.lowerValue) \(rangeSlider.upperValue))"
      print("Range slider value changed: \(values)")
    }

}


extension ProfileDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            cell.backgroundColor = .yellow
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


struct ProfileDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let controller = ProfileDetailViewController()
            return UINavigationController(rootViewController: controller)
        }
    
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
        
        typealias UIViewControllerType = UIViewController
    }
}
