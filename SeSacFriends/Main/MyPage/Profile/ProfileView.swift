//
//  ProfileView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/03.
//

import UIKit


class ProfileView: BaseUIView {
    
    let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .yellow
        $0.showsVerticalScrollIndicator = false
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
        }

        contentView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        cardView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(500)
        }
//
        detailView.snp.makeConstraints {
            $0.top.equalTo(cardView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().offset(-16)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
