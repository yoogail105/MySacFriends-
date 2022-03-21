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
    
    
    
    static func fittingSize(availableHeight: CGFloat, name: String?) -> CGSize {
     let cell = TitleCollectionViewCell()
        cell.setTitle(name: name)
        
        let targetSize = CGSize(width: UIView.layoutFittingExpandedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    
    private func setTitle(name: String?) {
        titleLabel.text = name
    }
    
    let titleLabel = UILabel().then {
        $0.font = UIFont().Title4_R14
        $0.textColor = UIColor.black
        $0.textAlignment = .center
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = .white
    }
    
    private override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configure()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.grayColor(.gray3).cgColor
    }
    
    private func constraints() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(5)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}




