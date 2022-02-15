//
//  RecommendCollectionViewCell.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/14.
//

import UIKit
import SnapKit

class RecommendCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendCollectionViewCell"
    
    var titleLabel = UILabel().then {
        
        $0.font = UIFont().Title4_R14
        $0.textColor = UIColor.systemColor(.error)
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
        
        self.layer.borderColor = UIColor.systemColor(.error).cgColor
    }
    
    private func constraints() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(5)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
