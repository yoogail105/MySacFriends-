//
//  OnboardingCardViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/21.
//

import Foundation
import UIKit

/*컨트롤러 줄일 수 있는 코드 예시*/
//
//for i in 0..<colors.count {
//            let vc = ExampleViewController()
//            vc.theLabel.text = "Page: \(i)"
//            vc.view.backgroundColor = colors[i]
//            pages.append(vc)

class OnboardingCard01ViewController: BaseViewController {
    
    var mainView = OnboardingCardView()
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
}

//관심사가 같은 친구를\n찾을 수 있어요
// SeSAC Frineds


class OnboardingCard02ViewController: OnboardingCard01ViewController {
    
    
    override func loadView() {
        self.view = mainView
        mainView.titleLabel.text = "관심사가 같은 친구를\n찾을 수 있어요"
        mainView.centerImage.image = UIImage(named: OnboardingImages.onboardingImage02.rawValue)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
}

class OnboardingCard03ViewController: OnboardingCard01ViewController {
   
    override func loadView() {
        self.view = mainView
        mainView.titleLabel.text = "SeSAC Friends"
        mainView.centerImage.image = UIImage(named: OnboardingImages.onboardingImage03.rawValue)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
}
