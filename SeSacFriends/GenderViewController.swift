//
//  GenderViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//

import UIKit
import RxCocoa
import RxSwift

class GenderViewController: BaseViewController {
    
    let mainView = GenderView()
    let viewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bind() {
        
    }
    
    private func moveToNext() {
        UserDefaults.standard.nickname = mainView.textField.text!
        let vc = EmailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
