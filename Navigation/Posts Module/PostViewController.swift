//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class PostViewController: UIViewController {
    
    var coordinator: BaseCoordinator?
    
    private lazy var editButton: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button.target = self
        button.title = LocalizableStrings.edit.rawValue.localize()
        button.style = .plain
        button.action = #selector(tapButton)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = LocalizableStrings.post.rawValue.localize()
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc private func tapButton() {
        coordinator?.showNextViewController()
    }
}

