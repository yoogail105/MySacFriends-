//
//  CollectionHeaderView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/16.
//

import UIKit
import SnapKit

class CollectionHeaderView: UICollectionReusableView {
    
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
        sectionNameLabel.font = UIFont().Body1_M16
        sectionNameLabel.textColor = .black
        sectionNameLabel.sizeToFit()
        
        addSubview(sectionNameLabel)
        
        sectionNameLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
