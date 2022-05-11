//
//  FindViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/15.
//


import UIKit
import RxSwift
import RxCocoa

import Tabman
import Pageboy



final class FindViewController: TabmanViewController {
    
    private var viewControllers: Array<UIViewController> = []
    
    var mainView = FindView()
    let viewModel = QueueViewModel()
    
    weak var coordinator: HomeCoordinator?
    let disposeBag = DisposeBag()
    
    var timeTrigger = true
    var realTime = Timer()

    
    override func loadView() {
        self.view = mainView
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        updateFriends()
        print("FindViewController: ", viewModel.currentLatitude)
        
        
        let firstVC = NearByViewController()
        let secondVC = ReceivedViewController()
        
//        let near = coordinator?.pushToNear()
//        let received = coordinator?.pushToReceived()
//
        viewControllers.append(firstVC)
        firstVC.viewModel = viewModel
        firstVC.coordinator = coordinator
        viewControllers.append(secondVC)
        secondVC.viewModel = viewModel
        secondVC.coordinator = coordinator
        
    
        
        self.dataSource = self
        let bar = mainView.bar
        addBar(bar, dataSource: self, at: .top)
        
        bind()
        startRepeatCheckUserStatus()
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = HobbyViewText.findFriend.rawValue
        self.navigationItem.backButtonTitle = ""
        let backButton = UIBarButtonItem(image: UIImage(named: AssetIcon.backArrow.rawValue), style: .done, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = backButton
        
        let stopButton = UIBarButtonItem(title: FindText.stopFinding.rawValue, style: .done, target: self, action: #selector(stopFindingButtonClicked))
        self.navigationItem.rightBarButtonItem = stopButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
    }
    
    
    @objc func back() {
        coordinator?.pushToMatchingMap(lat: viewModel.currentLongitude, long: viewModel.currentLongitude, myHobbyList: viewModel.myHobbyList)
    }
    
    @objc func stopFindingButtonClicked() {
        viewModel.stopFinding()
        viewModel.onErrorHandling = { result in
            switch result {
            case .ok:
                self.coordinator?.startPush()
                
            case .created:
                self.showToastWithAction(message: FindingToast.alreadyMatched.rawValue) {
                    self.coordinator?.pushToChatting()
                }
                print("notacceptable")
            case .notAcceptable:
                self.showToastWithAction(message: notAcceptable.notAcceptableUser.rawValue) {
                    self.coordinator?.finishToOnboarding()
                }
            default:
                self.showToast(message: APIErrorMessage.unKnownError.rawValue)
            }
            
        }
        
    }
    
    func startRepeatCheckUserStatus() {
        print(#function)
        realTime = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(checkUserStatus), userInfo: nil, repeats: true)
    }
    
    @objc func checkUserStatus() {
        print(#function)
        viewModel.checkUserStatus()
        viewModel.onErrorHandling = { result in
            switch result {
            case .ok:
                let myStatus = self.viewModel.myStatus
                if myStatus?.matched == 1 {
                    
                    let partner = myStatus?.matchedNick
                    self.showToastWithAction(message: "partner" +  UserStatusToast.alreadyMatched.rawValue) {
                        self.coordinator?.pushToChatting()
                    }
                }
                 return
            case .created:
                self.realTime.invalidate()
                self.showToastWithAction(message: UserStatusToast.alreayDone.rawValue) {
                    self.coordinator?.startPush()
                }
                
            default:
                self.showToast(message: APIErrorMessage.unKnownError.rawValue)
            }
        }
    }
    
    func bind(){
        mainView.changeButton.rx.tap
            .bind {
                self.changeHobby()
            }
            .disposed(by: disposeBag)
        
        mainView.refreshButton.rx.tap
            .bind {
                self.updateFriends()
            }
            .disposed(by: disposeBag)
        

//        
//        viewModel.requestedFriendsObserver
//            .map { !self.isFirstTab && $0.count == 0 ? false : true }
//            .bind(to: self.mainView.sesacBlackImage.rx.isHidden,
//                  self.mainView.emptyFriendsTitle.rx.isHidden,
//                  self.mainView.emptyFriendsSubtitle.rx.isHidden
//            )
//            .disposed(by: disposeBag)
        
    }
    
    func changeHobby() {
        viewModel.stopFinding()
        viewModel.onErrorHandling = { result in
            switch result {
            case .ok:
                self.coordinator?.pushToSearchHobby(lat: self.viewModel.currentLatitude, long: self.viewModel.currentLongitude, myHobbyList: self.viewModel.myHobbyList)
//                self.coordinator?.pushToSearchHobbyWithHobby(lat: self.viewModel.currentLatitude, long: self.viewModel.currentLongitude, myHobbyList: self.viewModel.myHobbyList)
            case .networkError:
                self.showToast(message: APIErrorMessage.networkError.rawValue)
            default:
                self.showToast(message: APIErrorMessage.unKnownError.rawValue)
            }
            
        }
    }
    
    func updateFriends() {
        viewModel.searchMatchedFriends()
        viewModel.onErrorHandling = { result in
            if result == .ok {
            }
        }
    }
}


extension FindViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: FindText.nearByFriends.rawValue)
            
        case 1:
            return TMBarItem(title: FindText.receivedRequests.rawValue)
        default:
            return TMBarItem(title: "\(index)")
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
