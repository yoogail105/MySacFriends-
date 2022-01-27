//
//  ProfileViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//

import UIKit

class MyPageViewController: UIViewController {
    
    let tableView = MyPageView().tableView
    let mainView = MyPageView()
    let viewModel = MyPageViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = TabBarTitle.myPage.rawValue
        tableView.delegate = self
        tableView.dataSource = self
        
    }

}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.identifier, for: indexPath) as? MyPageTableViewCell else {
//            return UITableViewCell()
//        }
       let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(systemName: "heart.fill")
        content.imageProperties.tintColor = .brandColor(.green)
        content.imageToTextPadding = 100

        
        content.attributedText = NSAttributedString(string: "Text", attributes: [ .font: UIFont.systemFont(ofSize: 20, weight: .bold), .foregroundColor: UIColor.systemBlue ])
        content.secondaryAttributedText = NSAttributedString(string: "secondaryText", attributes: [ .font: UIFont.systemFont(ofSize: 10, weight: .light), .foregroundColor: UIColor.systemGreen ])
        content.textProperties.alignment = .center
        content.secondaryTextProperties.alignment = .justified
        cell.contentConfiguration = content
      
        
        
        return cell
    }
    
    
}
