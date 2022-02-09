//
//  SearchView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/10.
//

import UIKit

class SearchView: BaseUIView {
    
    let searchButton = UIButton().then {
        $0.buttonMode(.fill, title: HomeText.findFriend.rawValue)
    }
    
    
    
    override func addViews() {
        [searchButton].forEach {
            addSubview($0)
        }
    }
    override func constraints() {
        searchButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
        }
    }
}
