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
    
    func buttonMode(_ mode: CustomButton, title: String) {
        
        switch mode {
        case .inactive:
            setTitle(title, for: .normal)
            setTitleColor(.black, for: .normal)
            backgroundColor = .white
            layer.borderWidth = 1
            layer.borderColor = UIColor.grayColor(.gray4).cgColor
            
            
        case .fill:
            setTitle(title, for: .normal)
            setTitleColor(.white, for: .normal)
            backgroundColor = UIColor.brandColor(.green)
            
        case .outline:
            setTitle(title, for: .normal)
            setTitleColor(UIColor.brandColor(.green), for: .normal)
            backgroundColor = .white
            layer.borderWidth = 1
            layer.borderColor = UIColor.brandColor(.green).cgColor
            
        case .cancel:
            setTitle(title, for: .normal)
            setTitleColor(UIColor.black, for: .normal)
            backgroundColor = UIColor.grayColor(.gray2)
            
        case .disable:
            setTitle(title, for: .normal)
            setTitleColor(UIColor.grayColor(.gray3), for: .normal)
            backgroundColor = UIColor.grayColor(.gray6)
        }
    }
    
    func buttonModeColor(_ mode: CustomButton) {
        
        switch mode {
        case .inactive:
            setTitleColor(.black, for: .normal)
            backgroundColor = .white
            layer.borderWidth = 1
            layer.borderColor = UIColor.grayColor(.gray4).cgColor
            
            
        case .fill:
            setTitleColor(.white, for: .normal)
            backgroundColor = UIColor.brandColor(.green)
            
        case .outline:
            setTitleColor(UIColor.brandColor(.green), for: .normal)
            backgroundColor = .white
            layer.borderWidth = 1
            layer.borderColor = UIColor.brandColor(.green).cgColor
            
        case .cancel:
            setTitleColor(UIColor.black, for: .normal)
            backgroundColor = UIColor.grayColor(.gray2)
            
        case .disable:
            setTitleColor(UIColor.grayColor(.gray3), for: .normal)
            backgroundColor = UIColor.grayColor(.gray6)
        }
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

class IconButton: BaseButton {
    override init(frame: CGRect) {
            super.init(frame: frame)
            configuration()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

    override func configuration() {
            layer.cornerRadius = 8
            clipsToBounds = true
            
        }
}


