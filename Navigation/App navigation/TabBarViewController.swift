//
//  TabBarViewController.swift
//  Navigation
//
//  Created by Егор Никитин on 23.12.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    let feedViewController = UINavigationController(rootViewController: FeedViewController())
    
    let logInViewController = UINavigationController(rootViewController: LogInViewController())
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [feedViewController, logInViewController]
        
        tabBarItemSettings()
        
    }
    
    func tabBarItemSettings()  {
        
        self.tabBar.tintColor = #colorLiteral(red: 0.2823529412, green: 0.5215686275, blue: 0.8, alpha: 1)
        
        feedViewController.tabBarItem.image = UIImage(named: "house")
        
        feedViewController.tabBarItem.title = "Feed"
        
        logInViewController.tabBarItem.image = UIImage(named: "person")
        
        logInViewController.tabBarItem.title = "Profile"
    }
    
}

