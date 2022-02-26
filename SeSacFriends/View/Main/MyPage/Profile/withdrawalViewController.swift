//
//  withdrawalViewController.swift
//  SeSACFriends
//
//  Created by 성민주민주 on 2022/02/07.
//


import UIKit
import RxSwift
import RxCocoa

final class withdrawalViewController: UIViewController {
    
    let mainView = AlertView()
    let viewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    weak var coordinator: MyPageCoordinator?
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // coordinator = MainCoordinator(navigationController: self.navigationController ?? UINavigationController())
        
        configure()
        bind()
    }
    
    func configure() {
        mainView.backgroundColor = .clear
        mainView.title.text = AlertText.withdrawalTitle.rawValue
        mainView.subTitle.text = AlertText.withdrawalSubtitle.rawValue
    }
    
    func bind() {
        mainView.okButton.rx.tap
            .bind {
                self.okButtonClicked()
            }
            .disposed(by: disposeBag)
        
        mainView.cancelButton.rx.tap
            .bind {
                self.cancelButtonClicked()
            }
            .disposed(by: disposeBag)
    }
    
    func okButtonClicked() {
        viewModel.onErrorHandling = { result in
            print(#function)
            switch result {
            case .ok, .notAcceptable:
                print("회원탈퇴완료되었습니다. 뷰컨")
                self.coordinator?.finishToOnboarding()
//                let vc = OnboardingViewController()
//                self.navigationController?.pushViewController(vc, animated: true)
            case .unAuthorized:
                self.okButtonClicked()
            case .networkError:
                self.showToast(message: APIErrorMessage.networkError.rawValue)
            default:
                self.showToast(message: APIErrorMessage.unKnownError.rawValue)
            }
        }
        self.viewModel.withdrawalUser()
    }
    
    func cancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}
