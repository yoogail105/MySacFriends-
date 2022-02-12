//
//  MyPageViewCell.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//

import UIKit
import SnapKit

class MyPageTableViewCell: UITableViewCell {
    static let identifier = "MyPageTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
}

