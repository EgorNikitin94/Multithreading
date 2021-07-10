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
    
    let favoritesPostsViewController = UINavigationController(rootViewController: FavoritesPostsViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [feedViewController, logInViewController, favoritesPostsViewController]
        
        tabBarItemSettings()
        
    }
    
    private func tabBarItemSettings() {
        
        self.view.backgroundColor = .white
        
        self.tabBar.tintColor = #colorLiteral(red: 0.2823529412, green: 0.5215686275, blue: 0.8, alpha: 1)
        
        feedViewController.tabBarItem.image = UIImage(named: "house")
        
        feedViewController.tabBarItem.title = LocalizableStrings.feed.rawValue.localize()
        
        logInViewController.tabBarItem.image = UIImage(named: "person")
        
        logInViewController.tabBarItem.title = LocalizableStrings.profile.rawValue.localize()
        
        favoritesPostsViewController.tabBarItem.image = UIImage(named: "star")
        
        favoritesPostsViewController.tabBarItem.title = LocalizableStrings.favorites.rawValue.localize()

    }
    
}

