//
//  FavoritPostsViewCoordinator.swift
//  Navigation
//
//  Created by Егор Никитин on 13.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class FavoritesPostViewCoordinator: BaseCoordinator {
    
    weak var parentCoordinator: BaseCoordinator?
    
    var navigator: UINavigationController
    
    var childCoordinators: [BaseCoordinator] = []
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func start() {
        navigator.tabBarItem.image = UIImage(named: "star")
        
        navigator.tabBarItem.title = LocalizableStrings.favorites.rawValue.localize()
    }
    
    func showNextViewController()  {
        
    }
    
    func childDidFinish(_ child: BaseCoordinator?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
    
    func didFinishCoordinator() {
        parentCoordinator?.childDidFinish(self)
    }

}
