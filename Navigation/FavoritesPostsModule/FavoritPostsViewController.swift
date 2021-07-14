//
//  FavoritPostsViewController.swift
//  Navigation
//
//  Created by Егор Никитин on 14.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import CoreData

final class FavoritesPostsViewController: UIViewController {
    
    
    // MARK: Properties
    
    var coordinator: BaseCoordinator?
    
    private var reuseID: String = "favoritPostReuseID"
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private lazy var findBarButton: UIBarButtonItem = {
        $0.image  =  UIImage(named: "loupe")
        $0.action = #selector(findPost)
        $0.style = .plain
        $0.target = self
        return $0
    }(UIBarButtonItem())
    
    private lazy var clearBarButton: UIBarButtonItem = {
        $0.title = LocalizableStrings.clear.rawValue.localize()
        $0.action = #selector(clearFinder)
        $0.style = .plain
        $0.target = self
        return $0
    }(UIBarButtonItem())
    
    private lazy var fetchResultController: NSFetchedResultsController<FavoritPost>  = {
        
        let request = FavoritPost.fetchRequest() as NSFetchRequest<FavoritPost>
        let nameSort = NSSortDescriptor(key: #keyPath(FavoritPost.author), ascending: true)
        request.sortDescriptors = [nameSort]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.sharedInstance.getContext(), sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = findBarButton
        navigationItem.leftBarButtonItem  = clearBarButton
        view.backgroundColor = .white
        
        title = LocalizableStrings.favoritesPosts.rawValue.localize()
        setupLayout()
        setupTableView()
        performResultController()
        
    }
    
    private func performResultController(predicate: NSPredicate? = nil) {
        
        fetchResultController.fetchRequest.predicate = predicate
        
        do {
            try fetchResultController.performFetch()
            tableView.reloadData()
        } catch {
            assertionFailure()
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func makePredicate(author: String) -> NSPredicate {
        NSPredicate(format: "%K LIKE %@", #keyPath(FavoritPost.author), "\(author)")
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
        let alertController = UIAlertController(title: LocalizableStrings.findPost.rawValue.localize(), message: LocalizableStrings.enterAuthor.rawValue.localize(), preferredStyle: .alert)
        alertController.addTextField { (text) in
            text.placeholder = LocalizableStrings.enterAuthor.rawValue.localize()
        }
        let alertActionFind = UIAlertAction(title: LocalizableStrings.search.rawValue.localize(), style: .default) { [weak self] (alert) in
            guard let self = self else { return }
            let searchedPost = alertController.textFields?[0].text
            if let post = searchedPost, post != "" {
                let predicate = self.makePredicate(author: post)
                self.performResultController(predicate: predicate)
            }
            
        }
        let alertActionCancel = UIAlertAction(title: LocalizableStrings.cancel.rawValue.localize(), style: .cancel, handler: nil)
        alertController.addAction(alertActionFind)
        alertController.addAction(alertActionCancel)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func clearFinder(_ sender: UIBarButtonItem) {
        performResultController()
    }
}


// MARK: Extensions DataSource and Delegate

extension FavoritesPostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let productItems = fetchResultController.fetchedObjects else {
            return 0
        }
        return productItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoritPost = fetchResultController.object(at: indexPath)
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! PostTableViewCell
        cell.configure(favoritPost)
        
        return cell
    }
    
}

extension FavoritesPostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favoritPost = fetchResultController.object(at: indexPath)
            CoreDataStack.sharedInstance.delete(object: favoritPost)
        }
    }
}



extension FavoritesPostsViewController: NSFetchedResultsControllerDelegate {
    
    private func controllerWillChangeContent(controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .move:
            break;
        case .update:
            break;
        @unknown default:
            break;
        }
    }
    
    private func controllerDidChangeContent(controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}



