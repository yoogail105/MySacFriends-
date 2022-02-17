//
//  ProfileViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//

import UIKit
import SnapKit

final class MyPageViewController: BaseViewController {
    let mainView = MyPageView()
    let viewModel = ProfileViewModel()
    
    var menuIcons = [""]

    
    override func loadView() {
        self.view = mainView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.navigationController?.navigationBar.isHidden = true
       //self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for icon in myPageMenuIcon.allCases {
            menuIcons.append(icon.rawValue)
        }

        let tableView = mainView.tableView
        view.backgroundColor = .white
       // title = TabBarTitle.myPage.rawValue
        
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    override func bind() {
        
    }
    
    override func setupNavigationBar() {

    }
    
    func getProfileData() {
        self.viewModel.getUser()
    }
    
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.menuTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == 0 {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageProfileTableViewCell.identifier, for: indexPath) as? MyPageProfileTableViewCell else {
            return UITableViewCell() }
            
            
            cell.selectionStyle = .none
            return cell
        
        } else {
            let cell = UITableViewCell()
            var content = cell.defaultContentConfiguration()
            
            content.text = viewModel.menuTitles[row]
            content.image = UIImage(named: menuIcons[row])
            content.attributedText = NSAttributedString(string: viewModel.menuTitles[row], attributes: [ .font: UIFont().Title2_R16, .foregroundColor: UIColor.black ])
            cell.separatorInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
            cell.contentConfiguration = content
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = ProfileViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 80
     }
}
