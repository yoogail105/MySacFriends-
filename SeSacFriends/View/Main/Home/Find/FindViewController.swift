//
//  FindViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/15.
//

import UIKit
import Tabman
import Pageboy
import Then
import SnapKit

final class FindViewController: TabmanViewController {
    
    private var viewControllers: Array<UIViewController> = []
    
    let mainView = FindView()
    let viewModel = FindViewModel()
    
    weak var coordinator: HomeCoordinator?

    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        let firstVC = NearByViewController()
        let secondVC = ReceivedViewController()
        
        viewControllers.append(firstVC)
        viewControllers.append(secondVC)
        
        self.dataSource = self
        let bar = mainView.bar
        addBar(bar, dataSource: self, at: .top)
        
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
        self.navigationController?.popViewController(animated: true)
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
