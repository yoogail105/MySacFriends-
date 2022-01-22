//
//  UITextField+Extension.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import Foundation
import UIKit

extension UITextField {
    func underLine(borderColor: CGColor) {
        print("underLine(borderColor: \(borderColor))")
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.size.height-1, width: self.frame.width, height: 1)
        border.borderWidth = 1
        border.borderColor = borderColor
        self.layer.addSublayer(border)
    }
    
    
}
