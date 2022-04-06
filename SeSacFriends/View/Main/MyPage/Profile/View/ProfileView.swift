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
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let contentView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
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
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
    
        cardView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(524)
        }

        detailView.snp.makeConstraints {
            $0.top.equalTo(cardView.snp.bottom).offset(8)
            $0.trailing.leading.bottom.equalToSuperview()
            $0.height.equalTo(350)
        }
    }
}
