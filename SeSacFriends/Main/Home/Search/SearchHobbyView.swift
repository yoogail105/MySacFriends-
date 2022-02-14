//
//  SearchView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/10.
//

import UIKit

class SearchHobbyView: BaseUIView {
    
    let backButton = UIButton().then {
        $0.setImage(UIImage(named: AssetIcon.backArrow.rawValue), for: .normal)
        
    }
    
    let searchBar = UISearchBar().then {
        $0.placeholder = HomeText.searchBarPlaceholder.rawValue
        $0.searchBarStyle = .minimal
    }
    
    // 취미 테이블뷰 (안에 콜렉션뷰)
    var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .yellow
        return collectionView
    }()
    
    
    // 찾기 버튼: api
    let searchButton = UIButton().then {
        $0.buttonMode(.fill, title: HomeText.findFriend.rawValue)
    }
    
    
    override func addViews() {
        [backButton, searchBar, collectionView, searchButton].forEach {
            addSubview($0)
        }
    }

    
    override func constraints() {
        
        collectionView.collectionViewLayout = layout()
        backButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalTo(searchBar.snp.centerY)
            $0.leading.equalToSuperview().offset(16)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(44)
            $0.leading.equalTo(backButton.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-16)
            
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(32)
            $0.bottom.equalTo(searchButton.snp.top).offset(-32)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        
        searchButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
        }
    }
    
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, environment -> NSCollectionLayoutSection?  in
            guard let self = self else { return nil }
            return self.createBasicTypeSection()
        }
    }

    private func createBasicTypeSection() -> NSCollectionLayoutSection {
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(10), heightDimension: .absolute(32))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        // layout
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
   
   
}
