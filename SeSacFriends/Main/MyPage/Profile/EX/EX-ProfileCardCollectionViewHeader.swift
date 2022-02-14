//
//  collectionHeaderView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/02.
//

import UIKit
import SnapKit

class collectionHeaderView: UICollectionReusableView {
    
    static let identifier = "collectionHeaderView"
    
    let sectionNameLabel = UILabel()
    
    
    override init(frame: CGRect) {
           super.init(frame: frame)
        layoutSubviews()
       }
       
       required init?(coder: NSCoder) {
           fatalError()
       }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .red
        sectionNameLabel.font = UIFont().Body1_M16
        sectionNameLabel.textColor = .black
        sectionNameLabel.sizeToFit()
        
        addSubview(sectionNameLabel)
        
        sectionNameLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
