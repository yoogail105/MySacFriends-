//
//  OnboardingView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/21.
//


import UIKit
import SnapKit


class OnboardingCardView: BaseUIView {
    let mainView = OnboardingView()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont().onboardingFont
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        // 38pt
        label.textAlignment = .center
        label.text = "위치 기반으로 빠르게\n주위 친구를 확인"
        return label
    }()

    var centerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: OnboardingImages.onboardingImage01.rawValue)
        return imageView
    }()

    override func constraints() {
        
        [
            titleLabel,centerImage
        ].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(centerImage.snp.top).offset(-56)
            $0.centerX.equalToSuperview()
        }

        centerImage.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.height.equalTo(centerImage.snp.width)

        }
    }
}
