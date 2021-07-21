//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Егор Никитин on 11.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class AppCoordinator {
    
    var navigator: UITabBarController
    
    var childCoordinators: [BaseCoordinator] = []
    
    init() {
        navigator = UITabBarController()
    }
    
    func start() {
        let feedViewController = FeedViewController()
        let feedViewCoordinator = FeedViewCoordinator(navigator: UINavigationController(rootViewController: feedViewController))
        feedViewController.coordinator = feedViewCoordinator
        
        let loginViewController = LogInViewController()
        let logInViewCoordinator = LoginViewCoordinator(navigator: UINavigationController(rootViewController: loginViewController))
        loginViewController.coordinator = logInViewCoordinator
        
        let favoritesPostsViewController = FavoritesPostsViewController()
        let favoritesPostsViewCoordinator = FavoritesPostViewCoordinator(navigator: UINavigationController(rootViewController: favoritesPostsViewController))
        favoritesPostsViewController.coordinator = favoritesPostsViewCoordinator
        
        childCoordinators.append(feedViewCoordinator)
        childCoordinators.append(logInViewCoordinator)
        childCoordinators.append(favoritesPostsViewCoordinator)
        
        navigator.viewControllers = [feedViewCoordinator.navigator, logInViewCoordinator.navigator, favoritesPostsViewCoordinator.navigator]
        
        navigator.view.backgroundColor = .white
        
        navigator.tabBar.tintColor = #colorLiteral(red: 0.2823529412, green: 0.5215686275, blue: 0.8, alpha: 1)
        
        feedViewCoordinator.start()
        
        logInViewCoordinator.start()
        
        favoritesPostsViewCoordinator.start()
        
    }
    
    func childDidFinish(_ child: BaseCoordinator?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
    
}
