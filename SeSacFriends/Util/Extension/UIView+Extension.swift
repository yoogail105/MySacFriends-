//
//  UIView+Extension.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/21.
//

import UIKit

extension UIView {
    
    public var height: CGFloat {
        get { return self.frame.size.height }
    }
    
    public var width: CGFloat {
        get { return self.frame.size.width}
    }
    
    func addShadow() {
        //layer.cornerRadius = 8
        //layer.borderWidth = 1
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 8
        layer.masksToBounds = false
    }
}

