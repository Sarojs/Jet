//
//  ViewController.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/11/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet private var table: UITableView! {
        didSet {
            table.rowHeight = UITableViewAutomaticDimension
            table.estimatedRowHeight = 150
        }
    }
    
    private var viewModels: [ArticleCellViewModel]? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.table.reloadData()
            }
        }
    }
    
    private let dataSource: ArticlesDataSource = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = PersistentDataManager.shared.persistentContainer.viewContext
        return ArticlesDataSource(context: context)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Users", style: .plain, target: self, action: #selector(showUsersList))
        
        // Fetch first page
        self.fetchArticles(for: 1)
    }
    
    private func fetchArticles(for page: Int) {
        self.dataSource.fetchArticle(pageIndex: page) { articles, error in
            self.viewModels = articles?.compactMap { ArticleCellViewModel(entity: $0) }
        }
    }
    
    // MARK: IBAction
    
    @objc func showUsersList() {
        self.navigationController?.pushViewController(UIStoryboard.viewController(with: "UserListViewController"),
                                                      animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCellView") as? ArticleCellView
            , let viewModel = viewModels?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let modelCount = self.viewModels?.count, indexPath.row == modelCount-1  else {
            return
        }
        
        if let modelCount = self.viewModels?.count {
            let nextPage = (modelCount/self.dataSource.pageSize) + 1
            self.fetchArticles(for: nextPage)
        }
    }
}
