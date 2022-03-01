//
//  NearBy.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/16.
//

import UIKit
import RxCocoa
import RxSwift

class NearByViewController: BaseViewController {
    
    let mainView = NearByView()
    weak var viewModel: QueueViewModel?
    weak var tableView: UITableView?
    let disposeBag = DisposeBag()
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = mainView.tableView
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(FriendCardTableViewCell.self, forCellReuseIdentifier: FriendCardTableViewCell.identifier)
        tableView?.register(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.identifier)
        tableView?.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        tableView?.register(ProfileCardReviewTableViewCell.self, forCellReuseIdentifier: ProfileCardReviewTableViewCell.identifier)
    }

    override func bind() {
        
        viewModel?.nearFriendsObserver
            .map { $0.count != 0 ? true : false }
            .bind(to: self.mainView.sesacBlackImage.rx.isHidden,
                  self.mainView.emptyFriendsTitle.rx.isHidden,
                  self.mainView.emptyFriendsSubtitle.rx.isHidden
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
    
    func updateFriends() {
        viewModel?.searchMatchedFriends()
        viewModel?.onErrorHandling = { result in
            if result == .ok {
                if self.viewModel!.nearFriends.count == 0 {
                    self.mainView.isEmpty = true
                } else {
                    print("NearByViewController: ", self.viewModel?.nearFriends)
                    self.mainView.isEmpty = false
                }
                print("ok: result")
            }
        }
    }

}

extension NearByViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("viewModel.nearFriends.count=\(viewModel?.nearFriends.count)")
        return viewModel!.nearFriendsObserver.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendCardTableViewCell.identifier, for: indexPath) as? FriendCardTableViewCell else {
            return UITableViewCell()
        }
        
        let row = viewModel!.nearFriends[indexPath.row]
        print("tableView: ", row.nick)
        cell.configureCell(row: row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 510
    }
    
}
