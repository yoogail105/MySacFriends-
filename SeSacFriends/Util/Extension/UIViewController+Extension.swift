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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: true)
        }
    }
    
    func showToastWithAction(message: String, action: @escaping () -> Void ) {
        let toast = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        self.present(toast, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: true, completion: action )
        }
    }
    
   
    
    
    func showToastAndPop(message: String) {
        
        self.view.tintColor = UIColor(named: "SSACGreen")
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.dismiss(animated: true) {
                self.navigationController?.popViewController(animated: true)
            }
        })
        
    }
}
