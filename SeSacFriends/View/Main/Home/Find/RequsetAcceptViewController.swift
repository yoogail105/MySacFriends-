//
//  RequsetAcceptViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/03/07.
//

import UIKit
import RxSwift
import RxCocoa

final class RequestAcceptViewController: BaseViewController {
    
    
    let mainView = AlertView()
    weak var viewModel: QueueViewModel?
    weak var coordinator: HomeCoordinator?
    var isRequest = true
    var uid = ""
    
    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAlert()
    }
    
    private func setupAlert() {
        mainView.backgroundColor = .clear
        var title = ""
        var subtitle = ""
        switch isRequest {
        case true:
            title = AlertText.requestTitle.rawValue
            subtitle = AlertText.requestSubTitle.rawValue
        case false:
            title = AlertText.acceptTogetherTitle.rawValue
            subtitle = AlertText.acceptTogetherSubtitle.rawValue
        }
        
        mainView.title.text = title
        mainView.subTitle.text = subtitle
    }
    
    override func bind() {
        mainView.okButton.rx.tap
            .subscribe(onNext: {
                self.okButtonClicked()
            })
        mainView.cancelButton.rx.tap
            .subscribe(onNext: {
                self.cancelButtonClicked()
            })
    }
    
    func requestTogether(uid: String) {
        viewModel?.requestTogether(uid: uid)
        viewModel?.onErrorHandling = { result in
            switch result {
            case .ok:
                self.showToast(message: TogetherToast.requestSuccess.rawValue)
            case .created:
                print("hobbyaccept호출")
                self.acceptTogeter(uid: uid)

            case .invalidRequest:
                self.showToast(message: TogetherToast.invalidRequest.rawValue)
            default:
                self.showToast(message: APIErrorMessage.unKnownError.rawValue)
            }
        }
    }
    
    func acceptTogeter(uid: String) {
        viewModel?.acceptTogether(uid: uid)
        
//        viewModel?.onErrorHandling = { result in
//            switch result {
//            case .ok:
//                print("채팅화면으로 이동")
//            case .created:
//                self.showToast(message: TogetherToast.created.rawValue)
//            case .invalidRequest:
//                self.showToast(message: TogetherToast.invalidRequest.rawValue)
//            case .firstPenalty:
//                self.showToast(message: TogetherToast.alreadyMatched.rawValue)
//            default:
//                self.showToast(message: APIErrorMessage.unKnownError.rawValue)
//            }
//        }
    }
    
    func okButtonClicked() {
        self.dismiss(animated: true) {
            switch self.isRequest {
            case true:
                print("사라짐")
                self.requestTogether(uid: self.uid)
            case false:
                self.acceptTogeter(uid: self.uid)
            }
        }
//        self.dismiss(animated: true, completion: nil)
//        coordinator?.finish()
        //        coordinator.pushtofi
        //        self.dismiss(animated: true) {
        //            switch self.isRequest {
        //            case true:
        //                print("사라짐")
        //                self.requestTogether(uid: self.uid)
        //            case false:
        //                self.acceptTogeter(uid: self.uid)
        //            }
        //        }
    }
    
    func cancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}


