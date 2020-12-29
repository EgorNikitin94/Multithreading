//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Егор Никитин on 29.10.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet private var profileHeaderView: ProfileHeaderView! {
        didSet {
            profileHeaderView.toAutoLayout()
            
        }
        
    }
    
    private var reuseID: String {
        return String(describing: PostTableViewCell.self)
    }
    
    private var reuseIDTwo: String {
        return String(describing: PhotosTableViewCell.self)
    }
    
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        profileHeaderView.widthAnchor.constraint(equalTo: tableView.widthAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTableView()
        
    }
    
    private func setupTableView() {
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: reuseID)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: reuseIDTwo)
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


extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = (section == 1 ? Storage.news.count : 1)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.section == 0 {
            let cellOne: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIDTwo, for: indexPath) as! PhotosTableViewCell
            cell = cellOne
        } else {
            let cellTwo: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! PostTableViewCell
            
            let post: Post = Storage.news[indexPath.row]
            cellTwo.configure(post: post)
            cell = cellTwo
        }
        return cell
    }
    
}


extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = [0, 0]
        if indexPath.elementsEqual(index) {
            let photosViewController = PhotosViewController()
            self.navigationController?.pushViewController(photosViewController, animated: true)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = (section == 0 ? profileHeaderView : nil)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let heightForHeader = (section == 0 ? UITableView.automaticDimension : .zero)
        return heightForHeader
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let heightForFooter = (section == 0 ? CGFloat(8) : .zero)
        return heightForFooter
    }
}
