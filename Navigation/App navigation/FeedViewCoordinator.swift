//
//  FeedViewCoordinator.swift
//  Navigation
//
//  Created by Егор Никитин on 13.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class FeedViewCoordinator: BaseCoordinator {
    
    weak var parentCoordinator: BaseCoordinator?
    
    var navigator: UINavigationController
    
    var childCoordinators: [BaseCoordinator] = []
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func showNextViewController() {
        let postViewCoordinator = PostViewCoordinator(controller: navigator, parent: self)
        postViewCoordinator.navigator = navigator
        childCoordinators.append(postViewCoordinator)
        postViewCoordinator.start()
    }
    
    func start() {
        navigator.tabBarItem.image = UIImage(named: "house")
        
        navigator.tabBarItem.title = LocalizableStrings.feed.rawValue.localize()
    }
    
    func childDidFinish(_ child: BaseCoordinator?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
    
    func didFinishCoordinator() {
        parentCoordinator?.childDidFinish(self)
    }
    
    
}

