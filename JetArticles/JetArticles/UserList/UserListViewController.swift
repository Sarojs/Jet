//
//  UserListViewController.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/13/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    
    private let dataSource: UserListDataSource = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = PersistentDataManager.shared.persistentContainer.viewContext
        return UserListDataSource(context: context)
    }()
    
    private var viewModels: [UserCellViewModel]? {
        didSet {
            self.table.reloadData()
        }
    }
    
    @IBOutlet private var table: UITableView! {
        didSet {
            table.dataSource = self
            table.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Users"
        
        // Fetch initial list of user
        self.fetchUsers(for: 1)
    }
    
    private func fetchUsers(for page: Int) {
        self.dataSource.fetchUserList(pageIndex: page) { users, error in
            self.viewModels = users?.compactMap { UserCellViewModel(entity: $0) }
        }
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as? UserTableViewCell,
            let viewModel = self.viewModels?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel)
        return cell
    }
}

extension UserListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let controller = UIStoryboard.viewController(with: "UserDetailViewController") as? UserDetailViewController,
              let userDetailEntity = self.viewModels?[indexPath.row].userEntity else {
            return
        }
        controller.viewModel = UserDetailViewModel(with: userDetailEntity)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let modelCount = self.viewModels?.count, indexPath.row >= modelCount-1  else {
            return
        }
        
        if let modelCount = self.viewModels?.count {
            let nextPage = (modelCount/self.dataSource.pageSize) + 1
            self.fetchUsers(for: nextPage)
        }
    }
}
