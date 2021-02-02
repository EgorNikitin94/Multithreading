//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Егор Никитин on 29.10.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

protocol ProfileViewControllerOutput {
    var avatar: UIImage { get }
    func configurePost(post: Post) -> (author: String, image: UIImage?, description: String, likes: String, views: String)
    func configurePhotos() -> [UIImage]
}

final class ProfileViewController: UIViewController {
    
    // MARK: Properties
    
    private let coordinator: ChildCoordinator
    
    private let viewModel: ProfileViewControllerOutput
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        
        return view
    }()
    
    private var reuseID: String {
        return String(describing: PostTableViewCell.self)
    }
    
    private var reuseIDTwo: String {
        return String(describing: PhotosTableViewCell.self)
    }
    
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    
    // Mark: - init
    
    init(coordinator: ChildCoordinator, viewModel: ProfileViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTableView()
        profileHeaderView.frame.size.width = self.view.frame.size.width
        self.navigationController?.navigationBar.isHidden = true
        configureAvatar(image: viewModel.avatar)
    }
    
    // MARK: Setup
    
    private func configureAvatar(image: UIImage) {
        profileHeaderView.avatarImageConfigure = image
    }
    
    private func configurePhotosTableViewCell(cell: PhotosTableViewCell, images: [UIImage]) {
        cell.cellConfigure = images
    }
    
    private func configureCell(cell: PostTableViewCell, data: (author: String, image: UIImage?, description: String, likes: String, views: String)) {
        cell.cellConfigure = (author: data.author, image: data.image, description: data.description, likes: data.likes, views: data.views)
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





// MARK: Extensions DataSource and Delegate

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
            
            let photos = viewModel.configurePhotos()
            configurePhotosTableViewCell(cell: cellOne, images: photos)
            cell = cellOne
        } else {
            let cellTwo: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! PostTableViewCell
            
            let post: Post = Storage.news[indexPath.row]
            let data = viewModel.configurePost(post: post)
            configureCell(cell: cellTwo, data: data)
            cell = cellTwo
        }
        return cell
    }
    
}


extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = [0, 0]
        if indexPath.elementsEqual(index) {
            let photosViewController = PhotosViewController(coordinator: coordinator)
            coordinator.push(viewController: photosViewController)
            
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

