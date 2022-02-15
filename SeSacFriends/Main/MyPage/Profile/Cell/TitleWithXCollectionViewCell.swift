//
//  TitleWithXCollectionViewCell.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/14.
//
import UIKit
import SnapKit

class TitleWithXCollectionViewCell: UICollectionViewCell {
    static let identifier = "TitleWithXCollectionViewCell"

    
    let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = UIColor.brandColor(.green)
        $0.font = UIFont().Title4_R14
    }
    
    let cancelImage = UIImageView().then {
        $0.image = UIImage(named: AssetIcon.closeSmallGreen.rawValue)
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = .white
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configuration()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.brandColor(.green).cgColor
    }
    func constraints() {
        [titleLabel, cancelImage].forEach {
            contentView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(cancelImage.snp.leading).offset(-4)
        }
        
        cancelImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
    }
}

