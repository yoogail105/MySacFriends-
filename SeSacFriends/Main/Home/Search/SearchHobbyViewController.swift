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



final class SearchHobbyViewController: BaseViewController {
    
    let mainView = SearchHobbyView()
    let viewModel = QueueViewModel()
    
    let searchBar = UISearchBar()
    var collectionView: UICollectionView?
    let disposeBag = DisposeBag()
    

    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        updateHobby()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        collectionView = mainView.collectionView
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
              flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            }
//willShow
        
        collectionView?.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderView.identifier)
        
        collectionView?.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
        collectionView?.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        collectionView?.register(TitleWithXCollectionViewCell.self, forCellWithReuseIdentifier: TitleWithXCollectionViewCell.identifier)
    
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        searchBar.placeholder = HobbyViewText.searchBarPlaceholder.rawValue
        self.navigationItem.titleView = searchBar
        
    }
    
    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
        print("터치함")
            self.searchBar.endEditing(true)
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
    
    override func bind() {
        //viewmodel에서 벨리드 조건 확인하기
        searchBar.rx.text
            .orEmpty
            .subscribe(onNext: { hobbies in
                hobbies.components(separatedBy: " ").forEach {
                    if $0.count > 8 {
                        self.showToast(message: AddMyHobbyToast.lengthLimit.rawValue)
                    } else if self.viewModel.myHobbyList.contains($0) {
                        self.showToastWithAction(message: AddMyHobbyToast.existedHobby.rawValue) {
                            self.searchBar.text = self.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                        }
                    }
                }
            }).disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .subscribe(onNext: {
                let input = self.searchBar.text
                if input != "" {
                    let hobbiesArray = input?.components(separatedBy: " ")
                    if hobbiesArray!.count + self.viewModel.myHobbyList.count > 8 {
                        self.showToast(message: AddMyHobbyToast.numberLimit.rawValue)
                    } else {
                        self.searchBar.text = ""
                        hobbiesArray?.forEach({
                            if $0 != "", !self.viewModel.myHobbyList.contains($0) {
                            self.viewModel.myHobbyList.append($0)
                            }
                        })
                        self.collectionView?.reloadData()
                    }
                }
                print(self.viewModel.myHobbyList)
            })
            .disposed(by: disposeBag)
        
        mainView.searchButton.rx.tap
            .bind {
                self.searchButtonClicked()
            }
            .disposed(by: disposeBag)
        
    }
    
    
    func searchButtonClicked() {
        print("시작")
        viewModel.onErrorHandling = { result in
            switch result {
            case .ok:
                print("화면이동함")
                let vc = FriendsViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            case .unAuthorized:
                self.searchButtonClicked()
            case .created:
                self.showToast(message: RequestFriendToast.created.rawValue)
            case .firstPenalty:
                self.showToast(message: RequestFriendToast.firstPenalty.rawValue)
            case .secondPenalty:
                self.showToast(message: RequestFriendToast.secondPenalty.rawValue)
            case .finalPenalty:
                self.showToast(message: RequestFriendToast.finalPenalty.rawValue)
            case .emptyGender:
                self.showToastWithAction(message: RequestFriendToast.emptyGender.rawValue, action: {
                    //화면전환
                })
            default:
                print(result)
            }
            
        }
        viewModel.requestFindHobbyFriends()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
    self.view.endEditing(true)
    }
    
    
}

extension SearchHobbyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderView.identifier, for: indexPath) as? CollectionHeaderView else {
             return UICollectionReusableView()
         }
        switch indexPath.section {
        case 0:
            headerView.sectionNameLabel.text = HobbyViewText.collectionViewHeader01.rawValue
        default:
            headerView.sectionNameLabel.text = HobbyViewText.collectionViewHeader02.rawValue
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            if indexPath.item <= self.viewModel.fromRecommendHobbyList.count-1 {
                return TitleCollectionViewCell.fittingSize(availableHeight: 32, name: viewModel.fromRecommendHobbyList[indexPath.item])
            } else {
                return TitleCollectionViewCell.fittingSize(availableHeight: 32, name: viewModel.friendsHobbyList[indexPath.item])
            }
        default:
            return TitleCollectionViewCell.fittingSize(availableHeight: 32, name: viewModel.myHobbyList[indexPath.item])
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.item <= self.viewModel.fromRecommendHobbyList.count-1 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as? RecommendCollectionViewCell else { return UICollectionViewCell() }
            
                cell.titleLabel.text = viewModel.fromRecommendHobbyList[indexPath.item]
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
                
                cell.titleLabel.text = viewModel.friendsHobbyList[indexPath.item]
                return cell
            }
            
        default:
           
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleWithXCollectionViewCell.identifier, for: indexPath) as? TitleWithXCollectionViewCell else { return UICollectionViewCell() }
                cell.titleLabel.text = viewModel.myHobbyList[indexPath.item]
            return cell
            }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        
        switch indexPath.section {
        case 0:
            if viewModel.myHobbyList.count == 8 {
                showToast(message: AddMyHobbyToast.numberLimit.rawValue)
                return
            }
            
            var selectedHobby = ""
            if indexPath.item <= self.viewModel.fromRecommendHobbyList.count-1 {
                guard let cell = collectionView.cellForItem(at: indexPath) as? RecommendCollectionViewCell else{ return }
                selectedHobby = cell.titleLabel.text!
                
            } else {
                guard let cell = collectionView.cellForItem(at: indexPath) as? TitleCollectionViewCell else{ return }
                selectedHobby = cell.titleLabel.text!
            }
            
            if !self.viewModel.myHobbyList.contains(selectedHobby){
                self.viewModel.myHobbyList.append(selectedHobby)
            } else {
                showToast(message: AddMyHobbyToast.existedHobby.rawValue)
            }
            
            //collectionView.reloadSections(IndexSet(integer: 1))
            collectionView.reloadData()
        default:
            collectionView.deleteItems(at: [IndexPath(row: row, section: 1)])
            self.viewModel.myHobbyList.remove(at: row)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
           
           let width: CGFloat = collectionView.frame.width
           let height: CGFloat = 18
           return CGSize(width: width, height: height)
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           
           return UIEdgeInsets.init(top: 16, left: 0, bottom: 16, right: 0)
       }
    
}
extension SearchHobbyViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
            self.searchBar.endEditing(true)
        }
}


