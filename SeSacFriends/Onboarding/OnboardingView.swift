//
//  OnboardingView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/22.
//


import UIKit
import SnapKit

class OnboardingView: BaseUIView {

   
    
    let pageView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        
        pageControl.frame = CGRect()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = 3
        //pageControl.currentPage = PageViewController().initialPage
        pageControl.translatesAutoresizingMaskIntoConstraints = true
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()


    let startButton: BaseButton = {
        let button = BaseButton(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        button.buttonMode(.fill, title: "시작하기")
        button.titleLabel?.font = UIFont().Body3_R14
        button.titleLabel?.textColor = UIColor.white
        return button
    }()
    
    
    
    
    override func constraints() {
        
//        pageView.addSubview(pageViewController.view)

        
        [
            pageView, startButton, pageControl
        ].forEach {
            addSubview($0)
        }
        
        pageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(pageControl.snp.top).offset(-56)

        }
        
        pageControl.snp.makeConstraints {
            $0.bottom.equalTo(startButton.snp.top).offset(-46)
            $0.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
            
        }
        
        
    }
}
