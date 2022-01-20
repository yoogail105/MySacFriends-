//
//  UIViewController+Extension.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/21.
//

import UIKit

extension UIViewController {
    
    
    func showToast(message: String) {
        let toast = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        self.present(toast, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dismiss(animated: true)
        }
    }
    
    
    func showToastAndPop(message: String) {
        
        self.view.tintColor = UIColor(named: "SSACGreen")
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.dismiss(animated: true) {
                self.navigationController?.popViewController(animated: true)
            }
        })
        
    }
}
