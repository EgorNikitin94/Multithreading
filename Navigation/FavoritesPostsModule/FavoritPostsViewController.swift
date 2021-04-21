//
//  FavoritPostsViewController.swift
//  Navigation
//
//  Created by Егор Никитин on 14.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class FavoritesPostsViewController: UIViewController {
    
    
    // MARK: Properties
    
    private var reuseID: String = "favoritPostReuseID"
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private var favoritesPostsContainer = [FavoritPost]()
    
    private lazy var findBarButton: UIBarButtonItem = {
        $0.image  =  UIImage(named: "loupe")
        $0.action = #selector(findPost)
        $0.style = .plain
        $0.target = self
        return $0
    }(UIBarButtonItem())
    
    private lazy var clearBarButton: UIBarButtonItem = {
        $0.title = "Clear"
        $0.action = #selector(clearFinder)
        $0.style = .plain
        $0.target = self
        return $0
    }(UIBarButtonItem())
    
    //MARK: LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesPostsContainer = CoreDataStack.sharedInstance.fetchData(for: FavoritPost.self)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = findBarButton
        navigationItem.leftBarButtonItem  = clearBarButton
        view.backgroundColor = .white
        
        title = "Favorites posts"
        setupLayout()
        setupTableView()
    }
    
    //MARK: Setup layout
    
    private func setupTableView() {
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: reuseID)
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        let constratints = [
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constratints)
    }
    
    //MARK: Actions
    
    @objc func findPost(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Find post", message: "Enter author", preferredStyle: .alert)
        alertController.addTextField { (text) in
            text.placeholder = "Enter author"
        }
        let alertActionFind = UIAlertAction(title: "Search", style: .default) { (alert) in
            let searchedPost = alertController.textFields?[0].text
            if let post = searchedPost, post != "" {
                self.favoritesPostsContainer = CoreDataStack.sharedInstance.searchObjects(for: FavoritPost.self, author: post)
                self.tableView.reloadData()
            }
            
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(alertActionFind)
        alertController.addAction(alertActionCancel)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func clearFinder(_ sender: UIBarButtonItem) {
        favoritesPostsContainer = CoreDataStack.sharedInstance.fetchData(for: FavoritPost.self)
        tableView.reloadData()
    }
}


// MARK: Extensions DataSource and Delegate

extension FavoritesPostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesPostsContainer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! PostTableViewCell
        
        let favoritPost: FavoritPost = favoritesPostsContainer[indexPath.row]
        cell.configure(favoritPost)
        
        return cell
    }
    
}

extension FavoritesPostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (contextualAction, view, boolValue) in
            let favoritPost: FavoritPost? = self?.favoritesPostsContainer[indexPath.row]
            self?.favoritesPostsContainer.remove(at: indexPath.row)
            self?.tableView.performBatchUpdates {
                self?.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let post = favoritPost {
                CoreDataStack.sharedInstance.delete(object: post)
                tableView.reloadData()
            }
        }
    
      return UISwipeActionsConfiguration(actions: [contextItem])
  }
}







