//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class PostViewController: UIViewController {
    
    private lazy var editButton: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button.target = self
        button.title = "Edit"
        button.style = .plain
        button.action = #selector(tapButton)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Post"
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func tapButton() {
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true, completion: nil)
        
    }
}

