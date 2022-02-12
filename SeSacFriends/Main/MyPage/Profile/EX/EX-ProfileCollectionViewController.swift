//
//  ProfileCollectionView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/02.
//

import Foundation
import RxCocoa
import UIKit
import SwiftUI

class ProfileCollectionViewController:  UICollectionViewController {
    
    
    
    var userTitles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for userTitle in UserTitleText.allCases {
            userTitles.append(userTitle.rawValue)
        }
        print(userTitles)
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true
        
    
        
    
        //collectionViewItem(cell) 설 설정
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        collectionView.register(ProfileCardCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileCardCollectionViewHeader.identifier)
        
        collectionView.collectionViewLayout = layout()
    }
    
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, environment -> NSCollectionLayoutSection?  in

            guard let self = self else { return nil }

            if self.userTitles != nil {

                return self.createBasicTypeSection()
            } else {
                return nil
            }

        }

    }
    
    private func createBasicTypeSection() -> NSCollectionLayoutSection {
      
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.2))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        // layout
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        return section
    }
}


extension ProfileCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return userTitles.count
//        switch section {
//        case 0:
//            return 1
//        default:
//            return userTitles.count
//
//        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
        
        cell.titleButton.setTitle(userTitles[indexPath.row], for: .normal)
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 셀 선택
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = userTitles[indexPath.section]
        print("Test: \(sectionName) 섹션의 \(indexPath.row + 1)번째 콘텐츠")
 }
    
    // 헤더뷰 설정
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileCardCollectionViewHeader.identifier, for: indexPath) as? ProfileCardCollectionViewHeader else {
                fatalError("Could not find dequeue header")
            }
            
            headerView.sectionNameLabel.text = "헤더"
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
   
}

// 미리보기

//struct ProfileCollectionViewController_Preview: PreviewProvider {
//    static var previews: some View {
//        Container().edgesIgnoringSafeArea(.all)
//    }
//
//    struct Container: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> UIViewController {
//            let layout = UICollectionViewLayout()
//            let controller = ProfileCollectionViewController(collectionViewLayout: layout)
//            return UINavigationController(rootViewController: controller)
//        }
//
//
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
//
//        typealias UIViewControllerType = UIViewController
//    }
//}
