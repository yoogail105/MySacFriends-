//
//  ProfileView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/03.
//

import UIKit
import SwiftUI


class ProfileView: BaseUIView {
    
    let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .yellow
        $0.showsVerticalScrollIndicator = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    let contentView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .red
    }

    let cardView = ProfileCardView()
    let detailView = ProfileDetailView()


    override func constraints() {
        
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        
        [cardView, detailView].forEach {
            contentView.addSubview($0)
            
        }
        
        scrollView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
            //$0.height.equalToSuperview()
            $0.centerX.equalToSuperview()
            //$0.width.equalTo(self.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.trailing.leading.equalToSuperview()
            //$0.width.equalToSuperview()
        }
        
    
        cardView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(500)
            $0.centerX.equalToSuperview()
        }

        detailView.snp.makeConstraints {
            $0.top.equalTo(cardView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
}
