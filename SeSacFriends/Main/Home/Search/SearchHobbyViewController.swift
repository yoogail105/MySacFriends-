//
//  SearchViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/10.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import simd



final class SearchHobbyViewController: UIViewController {
    
    let mainView = SearchHobbyView()
    let viewModel = QueueViewModel()
    let disposeBag = DisposeBag()
    var collectionView: UICollectionView?
    

    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        updateHobby()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = mainView.collectionView
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        collectionView?.register(collectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: collectionHeaderView.identifier)
        collectionView?.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
        collectionView?.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        collectionView?.register(TitleWithXCollectionViewCell.self, forCellWithReuseIdentifier: TitleWithXCollectionViewCell.identifier)
        
        bind()
    }
    
    func updateHobby() {
        viewModel.onErrorHandling = { result in
            if result == .ok {
                self.collectionView?.reloadData()
            }
        }
        
    viewModel.searchFriends()
        
    }
    
    func setCollectionView() {
       
    }
    
    func bind() {
        mainView.searchBar.rx.text
            .orEmpty
            .subscribe(onNext: { value in
                self.viewModel.myHobbyList.append(value)
                print(value)
            })
            .disposed(by: disposeBag)
    }
    
    
    
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        self.view.endEditing(true)
        
    }
}

extension SearchHobbyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: collectionHeaderView.identifier, for: indexPath) as? collectionHeaderView else {
             return UICollectionReusableView()
         }
        switch indexPath.section {
        case 0:
            headerView.sectionNameLabel.text = "지금 주변에는"
        default:
            headerView.sectionNameLabel.text = "내가 하고싶은"
        }
         return headerView
     }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            // 지금 주변에는
            return viewModel.friendsHobbyList.count
        default:
            // 내가 하고 싶은
            return viewModel.myHobbyList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.item <= 2 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as? RecommendCollectionViewCell else { return UICollectionViewCell() }
            
                cell.titleLabel.text = viewModel.fromRecommendHobbyList[indexPath.item]
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
                
                cell.titleLabel.text = viewModel.friendsHobbyList[indexPath.item]
                return cell
            }
            
        default:
           
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
            
           // cell.titleLabel.text = viewModel.myHobbyList[indexPath.item]
            return cell
            }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = "모뫄"
        print("Test: \(sectionName) 섹션 선택됨.")
    }
}

extension SearchHobbyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        //hhobbyview추가
    }
}
