//
//  BaseViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        bind()
        addAction()
        setupConstraints()
        setupNavigationBar()
    }
    
    func configure() {
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        
    }
    
    func bind() {
        
    }
    
    func addAction() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    func setupNavigationBar() {
        self.navigationItem.title = ""
        self.navigationItem.backButtonTitle = ""
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward.fill"), style: .done, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "SSACGreen")
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
