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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesPostsContainer = CoreDataStack.sharedInstance.fetchData(for: FavoritPost.self)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Favorites posts"
    
        setupLayout()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.toAutoLayout()
        tableView.dataSource = self
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







