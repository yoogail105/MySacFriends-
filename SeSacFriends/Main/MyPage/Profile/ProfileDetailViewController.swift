//
//  ProfileDetailViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/28.
//

import UIKit

class ProfileDetailViewController: BaseViewController, UIScrollViewDelegate {
    
    let mainView = ProfileView()
    var userTitles: [String] = []
    var sectionTitles: [String] = []
    
    override func loadView() {
        self.view = mainView
        
        mainView.scrollView.delegate = self
        let time = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.mainView.detailView.ageBar.trackHighlightTintColor = UIColor.brandColor(.green)
            self.mainView.detailView.ageBar.thumbImage = UIImage(named: AssetIcon.filterControl.rawValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        let saveButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(saveButtonClicked))
        
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
    }
    
    @objc func saveButtonClicked() {
        
    }
    
    override func addAction() {
        mainView.detailView.ageBar.addTarget(self, action: #selector(rangeSliderValueChanged(_:)),
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
