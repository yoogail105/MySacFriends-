//
//  UIButton+Extension.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/20.
//

import UIKit


enum CustomButton: String {
    case inactive
    case fill
    case outline
    case cancel
    case disable
}


extension UIButton {
    
    func inactive(title: String) {
        self.setTitle(title, for: .normal)
        self.tintColor = .black
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.grayColor(.gray4).cgColor
    }
    
    func fill(title: String) {
        self.setTitle(title, for: .normal)
        self.tintColor = .white
        self.backgroundColor = UIColor.brandColor(.green)
    }
    
    func outline(title: String) {
        self.setTitle(title, for: .normal)
        self.tintColor = UIColor.brandColor(.green)
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.brandColor(.green).cgColor
    }
    
    func cancel(title: String) {
        self.setTitle(title, for: .normal)
        self.tintColor = .black
        self.backgroundColor = UIColor.grayColor(.gray2)
    }
    
    func disable(title: String) {
        self.setTitle(title, for: .normal)
        self.tintColor = .white
        self.backgroundColor = UIColor.grayColor(.gray6)
    }
}


class BaseButton: UIButton {
    override init(frame: CGRect) {
            super.init(frame: frame)
            configuration()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            configuration()
        }

        func configuration() {
            layer.cornerRadius = 8
            clipsToBounds = true
            
        }
}
