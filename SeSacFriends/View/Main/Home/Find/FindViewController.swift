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
    
    let changeButton = BaseButton().then {
        $0.buttonMode(.fill, title: HobbyViewText.changeHobby.rawValue)
    }
    
    let refreshButton = BaseButton().then {
        $0.backgroundColor = .white
        $0.tintColor = UIColor.brandColor(.green)
        $0.setImage(UIImage(named: AssetIcon.refresh.rawValue), for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.brandColor(.green).cgColor
    }
    
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
        constraints()
        
        let firstVC = NearByViewController()
        let secondVC = RequestViewController()
        
        viewControllers.append(firstVC)
        viewControllers.append(secondVC)
        
        self.dataSource = self
        
        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        bar.backgroundView.style = .clear
        
        bar.buttons.customize { button in
            button.selectedTintColor =  UIColor.brandColor(.green)
            button.tintColor = UIColor.grayColor(.gray6)
               }
        bar.layout.contentMode = .fit
        bar.indicator.tintColor = UIColor.brandColor(.green)
        bar.indicator.overscrollBehavior = .bounce
        // Add to view
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
    
  
    func constraints() {
        [changeButton, refreshButton].forEach {
            view.addSubview($0)
        }
        
        changeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(48)
            $0.trailing.equalTo(refreshButton.snp.leading).offset(-8)
        }
        
        refreshButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(changeButton.snp.centerY)
        }
    }
}


extension FindViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
               case 0:
                   return TMBarItem(title: "주변 새싹")
               case 1:
                   return TMBarItem(title: "받은 요청")
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
