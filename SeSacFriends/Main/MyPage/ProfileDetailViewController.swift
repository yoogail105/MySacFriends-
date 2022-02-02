//
//  ProfileDetailViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/28.
//

import UIKit

class ProfileDetailViewController: BaseViewController {
    
    
    
    let mainView = ProfileDetailView()
    let headereView = ProfileHeaderView()
    
    override func loadView() {
        self.view = mainView
        
        
        let time = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.mainView.ageBar.trackHighlightTintColor = UIColor.brandColor(.green)
            self.mainView.ageBar.thumbImage = UIImage(named: AssetIcon.filterControl.rawValue)
        }
    

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TabBarTitle.detail.rawValue
        
        //        let tableView = mainView.profileTableView
        //        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.identifier)
        //        tableView.delegate = self
        //        tableView.dataSource = self
        //        tableView.isScrollEnabled = false
        //        tableView.rowHeight = UITableView.automaticDimension
    
    
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
        mainView.ageBar.addTarget(self, action: #selector(rangeSliderValueChanged(_:)),
                                  for: .valueChanged)
        
        
    }
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
      let values = "(\(rangeSlider.lowerValue) \(rangeSlider.upperValue))"
      print("Range slider value changed: \(values)")
    }

}


//extension ProfileDetailViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: NameTableViewCell.identifier, for: indexPath) as? NameTableViewCell else { return UITableViewCell()}
//
//
//
//
//        cell.selectionStyle = .none
//        return cell
//    }
//}
