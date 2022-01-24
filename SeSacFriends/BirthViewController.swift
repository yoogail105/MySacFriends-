//
//  BirthViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//

import UIKit
import RxSwift
import RxCocoa

class BirthViewController: BaseViewController {
    
    let mainView = BirthView()
    let viewModel = SignUpViewModel()
    let disposeBag = DisposeBag()

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("birth: viewdidload")
        print("nickname = \(UserDefaults.standard.nickname)")
    }
    
    override func bind() {
        
        mainView.nextButton.rx.tap
            .subscribe(onNext: { _ in
                self.moveToNext()
            })
            .disposed(by: disposeBag)
        
    }
    
    override func addAction() {
        mainView.datePicker.addTarget(self, action: #selector(onDidChangeDate), for: .valueChanged)
        
    }
    
    @objc func onDidChangeDate() {
        
    }
    
    private func moveToNext() {
        UserDefaults.standard.nickname = mainView.textField.text!
        let vc = EmailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
