//
//  BaseUIView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/21.
//


import UIKit
import SnapKit

class BaseUIView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configuration()
        constraints()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configuration() {
        
    }
    
    func constraints() {
        
    }
}
