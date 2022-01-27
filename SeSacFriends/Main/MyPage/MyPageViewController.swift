//
//  ProfileViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//

import UIKit
import SnapKit

class MyPageViewController: UIViewController {
    
    
    let mainView = MyPageView()
    let viewModel = MyPageViewModel()
    var menuIcons = [""]

    
    override func loadView() {
        self.view = mainView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for icon in myPageMenuIcon.allCases {
            menuIcons.append(icon.rawValue)
        }

        let tableView = mainView.tableView
        view.backgroundColor = .white
        title = TabBarTitle.myPage.rawValue
        
        tableView.delegate = self
        tableView.dataSource = self
       // tableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        
        
    }

}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.menuTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.identifier, for: indexPath) as? MyPageTableViewCell else {
//            return UITableViewCell()
//        }
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        let row = indexPath.row
        
        content.text = viewModel.menuTitles[row]
        cell.selectionStyle = .none

//        content.imageProperties.tintColor = .brandColor(.green)
//        content.imageToTextPadding = 100
        if row == 0 {
            content.image = UIImage(named: sesacIcon.face1.rawValue)
            content.attributedText = NSAttributedString(string: UserDefaults.standard.nickname, attributes: [ .font: UIFont().Title1_M16, .foregroundColor: UIColor.black ])
        } else {
            print("icon: \(menuIcons[row])")
            content.image = UIImage(named: menuIcons[row])
            content.attributedText = NSAttributedString(string: viewModel.menuTitles[row], attributes: [ .font: UIFont().Title2_R16, .foregroundColor: UIColor.black ])
        }
       
        
//        content.secondaryAttributedText = NSAttributedString(string: "secondaryText", attributes: [ .font: UIFont.systemFont(ofSize: 10, weight: .light), .foregroundColor: UIColor.systemGreen ])
//
        

        cell.separatorInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        cell.contentConfiguration = content
      
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
