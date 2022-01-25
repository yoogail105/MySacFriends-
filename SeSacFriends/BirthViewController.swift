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
    let calendar = Calendar.current

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("birth: viewdidload")
        print("nickname = \(UserDefaults.standard.nickname)")
    }
    
    override func bind() {
        
        mainView.datePicker.rx.value.changed.asObservable()
            .subscribe({ event in
                if let date = event.element {
                    
                    self.mainView.yearView.textField.text = String(self.calendar.component(.year, from: date))
                    self.mainView.monthView.textField.text = String(self.calendar.component(.month, from: date))
                    self.mainView.dayView.textField.text = String(self.calendar.component(.day, from: date))
                }
            })
            .disposed(by: disposeBag)
        
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
        UserDefaults.standard.birth = mainView.datePicker.date
        print("저장된 날짜: \(UserDefaults.standard.birth)")
        let vc = EmailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
