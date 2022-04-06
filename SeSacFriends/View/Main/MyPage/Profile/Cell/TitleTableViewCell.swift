//
//  ProfileCardTitleTableViewCell.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/03.
//

import UIKit
import SnapKit


class TitleTableViewCell: UITableViewCell {
    
    static let identifier = "ProfileCardTitleTableViewCell"
    
    var friend: Friend?
    
    var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var userTitles: [String] = []
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        for userTitle in UserTitleText.allCases {
            userTitles.append(userTitle.rawValue)
        }

        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func constraints() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-12)
        }
    }
    
}

extension TitleTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
        
        cell.titleLabel.text = userTitles[indexPath.row]
        
        guard let count = self.friend?.reputation[indexPath.row] else {
            return cell
        }
        
        if (self.friend?.reputation[indexPath.row])! != 0 {
            print("reputation: \(self.friend?.reputation[indexPath.row])")
            cell.backgroundColor = UIColor.brandColor(.green)
            cell.titleLabel.textColor = UIColor.white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.45
        
        return CGSize(width: width, height: 32)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = userTitles[indexPath.row]
        print("Test: \(sectionName) 섹션 선택됨.")
    }
}
