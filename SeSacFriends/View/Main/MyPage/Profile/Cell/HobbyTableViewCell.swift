//
//  HobbyTableViewCell.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/14.
//

import UIKit
import RxSwift

class HobbyTableViewCell: UITableViewCell {
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    var viewModel: QueueViewModel! {
        didSet {
         //   self.configure()
        }
    }
    
    let cellWidthHeightConstant: CGFloat = 100
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView
            .translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView
            .register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
}
