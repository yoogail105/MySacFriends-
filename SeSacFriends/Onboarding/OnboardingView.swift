//
//  OnboardingView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/21.
//


import UIKit
import SnapKit


class OnboardingView: BaseUIView {
    
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
    
    
    
    let startButton: BaseButton = {
        let button = BaseButton(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        button.buttonMode(.fill, title: "시작하기")
        button.titleLabel?.font = UIFont().Body3_R14
        button.titleLabel?.textColor = UIColor.white
        return button
    }()
    
    var centerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: OnboardingImages.onboardingImage01.rawValue)
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.red.cgColor
        return imageView
    }()
    
    let pageController: UIPageControl = {
        let initialPage = 0
        let pageController = UIPageControl()
        pageController.currentPageIndicatorTintColor = UIColor.black
        pageController.pageIndicatorTintColor = UIColor.lightGray
        pageController.numberOfPages = 3
        pageController.currentPage = initialPage
        pageController.translatesAutoresizingMaskIntoConstraints = false
        return pageController
    }()


    
    override func constraints() {
        
        [
            titleLabel, centerImage, startButton, pageController
        ].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(centerImage.snp.top).offset(-56)
            $0.centerX.equalToSuperview()
        }
        
        centerImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.height.equalTo(centerImage.snp.width)
            
        }
        
        startButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
            
        }
        
        pageController.snp.makeConstraints {
            $0.top.equalTo(centerImage.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
    }
}
