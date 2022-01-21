//
//  OnboardingViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/21.
//

import Foundation
import UIKit

class Onboarding01ViewController: BaseViewController {
    
    var mainView = OnboardingView()
    
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//관심사가 같은 친구를\n찾을 수 있어요
// SeSAC Frineds


class Onboarding02ViewController: Onboarding01ViewController {
    
    
    override func loadView() {
        self.view = mainView
        mainView.titleLabel.text = "관심사가 같은 친구를\n찾을 수 있어요"
        mainView.centerImage.image = UIImage(named: OnboardingImages.onboardingImage02.rawValue)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
}

class Onboarding03ViewController: Onboarding01ViewController {
   
    override func loadView() {
        self.view = mainView
        mainView.titleLabel.text = "SeSAC Friends"
        mainView.centerImage.image = UIImage(named: OnboardingImages.onboardingImage03.rawValue)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
}
