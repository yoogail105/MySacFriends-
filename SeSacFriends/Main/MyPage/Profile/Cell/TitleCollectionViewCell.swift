//
//  ProfileCollectionViewCell.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/31.
//

import UIKit
import SnapKit

class TitleCollectionViewCell: UICollectionViewCell {
    static let identifier = "TitleCollectionViewCell"
    
    var titleLabel = UILabel().then {
        
        $0.font = UIFont().Title4_R14
//        $0.textColor = UIColor.brandColor(.green)
        $0.textColor = UIColor.black
        $0.textAlignment = .center
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configure()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.brandColor(.green).cgColor
        self.layer.borderColor = UIColor.grayColor(.gray3).cgColor
    }
    
    func constraints() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
