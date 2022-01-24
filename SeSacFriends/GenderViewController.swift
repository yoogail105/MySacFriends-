//
//  GenderViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//

import UIKit
import RxCocoa
import RxSwift
import AVFoundation

class GenderViewController: BaseViewController {
    
    let mainView = GenderView()
    let viewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    var gender = UserDefaults.standard.gender
    var woman = false
    var man = false
    override func loadView() { 
        self.view = mainView

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("gender: viewdidload")
        print(userDefaults.gender)
        
    }
    
    enum isSelected: String {
        case on
        case off
    }
    
    override func bind() {
        
        viewModel.genderObserver
            .map { $0 == .woman ? UIColor.brandColor(.whitegreen) : UIColor.white }
            .bind(to: mainView.button00.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        viewModel.genderObserver
            .map { $0 == .man ? UIColor.brandColor(.whitegreen) : UIColor.white }
            .bind(to: mainView.button01.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        
       
        mainView.button00.rx.tap
            .scan(Gender.none, accumulator: { lastSelected, _ in
                switch lastSelected {
                case .woman:
                    if self.mainView.button00.backgroundColor == UIColor.white {
                        return .woman
                    }
                    return .none
                case .none:
                    return .woman
                case .man:
                    return .woman
                }
            })
            .bind(to: viewModel.genderObserver)
            .disposed(by: disposeBag)

        mainView.button01.rx.tap
            .scan(Gender.none, accumulator: { lastSelected, _ in
                switch lastSelected {
                case .woman:
                    return .man
                case .none:
                    return .man
                case .man:
                    if self.mainView.button01.backgroundColor == UIColor.white {
                        return .man
                    }
                    return .none
                }
            })
            .bind(to: viewModel.genderObserver)
            .disposed(by: disposeBag)
        
        mainView.nextButton.rx.tap
            .subscribe(onNext: { _ in
                self.moveToNext()
            })
            .disposed(by: disposeBag)

    }
    
    override func addAction() {
        mainView.button00.addTarget(self, action: #selector(womanButtonClicked), for: .touchUpInside)
        mainView.button01.addTarget(self, action: #selector(manButtonClicked), for: .touchUpInside)
    }
    
    @objc func womanButtonClicked() {
        var lastSelected = userDefaults.gender
        if lastSelected == Gender.woman.rawValue {
            userDefaults.gender = Gender.none.rawValue
        } else {
            userDefaults.gender = Gender.woman.rawValue
        }
    }
    
    @objc func manButtonClicked() {
        var lastSelected = userDefaults.gender
        if lastSelected == Gender.man.rawValue {
            userDefaults.gender = Gender.none.rawValue
        } else {
            userDefaults.gender = Gender.man.rawValue
        }
    }
    
    
    private func moveToNext() {
        // 유저정보 post
        let vc = EmailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
