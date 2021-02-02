//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class PostViewController: UIViewController {
    
    private let coordinator: ChildCoordinator
    
    private lazy var editButton: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button.target = self
        button.title = "Edit"
        button.style = .plain
        button.action = #selector(tapButton)
        return button
    }()
    
    // Mark: - init
    
    init(coordinator: ChildCoordinator) {
        self.coordinator = coordinator
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Post"
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc private func tapButton() {
        let infoViewController = InfoViewController(coordinator: coordinator)
        coordinator.present(viewController: infoViewController)
        
    }
}

