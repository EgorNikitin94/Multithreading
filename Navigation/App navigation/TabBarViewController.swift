//
//  TabBarViewController.swift
//  Navigation
//
//  Created by Егор Никитин on 23.12.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    static let shared = TabBarViewController()
    
    let feedViewController = UINavigationController(rootViewController: FeedViewController(output: PostPresenter()))
    
    let logInViewController = UINavigationController(rootViewController: LogInViewController())
    
    private init() {
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [feedViewController, logInViewController]
        
        tabBarItemSettings()
        
    }
    
    private func tabBarItemSettings() {
        
        self.view.backgroundColor = .white
        
        self.tabBar.tintColor = #colorLiteral(red: 0.2823529412, green: 0.5215686275, blue: 0.8, alpha: 1)
        
        feedViewController.tabBarItem.image = UIImage(named: "house")
        
        feedViewController.tabBarItem.title = "Feed"
        
        logInViewController.tabBarItem.image = UIImage(named: "person")
        
        logInViewController.tabBarItem.title = "Profile"
    }
    
}

