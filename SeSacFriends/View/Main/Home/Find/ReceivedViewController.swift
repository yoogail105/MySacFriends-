//
//  RequestViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/16.
//

import UIKit
import RxCocoa
import RxSwift

class ReceivedViewController: BaseViewController {
    let mainView = NearByView()
    weak var viewModel: QueueViewModel?
    weak var tableView: UITableView?
    let disposeBag = DisposeBag()
    
    
    override func loadView() {
        mainView.emptyTitle.text = HobbyViewText.emptyRequestTitle.rawValue
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
    
    override func bind() {
        
        viewModel?.requestedFriendsObserver
            .map { $0.count != 0 ? true : false }
            .bind(to: self.mainView.sesacBlackImage.rx.isHidden,
                  self.mainView.emptyTitle.rx.isHidden,
                  self.mainView.emptySubtitle.rx.isHidden
            )
            .disposed(by: disposeBag)
        
        viewModel?.isUpdate
            .subscribe(onNext: {
                if $0 {
                    self.tableView?.reloadData()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setTableView() {
        tableView = mainView.tableView
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(FriendCardTableViewCell.self, forCellReuseIdentifier: FriendCardTableViewCell.identifier)
        tableView?.register(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.identifier)
        tableView?.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        tableView?.register(ProfileCardReviewTableViewCell.self, forCellReuseIdentifier: ProfileCardReviewTableViewCell.identifier)
    }
    
    func acceptTogeter(uid: String) {
        viewModel?.requestTogether(uid: uid)
    }
}

extension ReceivedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("viewModel.nearFriends.count=\(viewModel?.requestedFriends.count)")
        return viewModel!.requestedFriendsObserver.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendCardTableViewCell.identifier, for: indexPath) as? FriendCardTableViewCell else {
            return UITableViewCell()
        }
        
        let row = viewModel!.requestedFriendsObserver.value[indexPath.row]
        cell.configureCell(row: row, status: true)
        let uid = row.uid
        cell.buttonAction = {
            self.acceptTogeter(uid: uid)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 510
    }
    
}
