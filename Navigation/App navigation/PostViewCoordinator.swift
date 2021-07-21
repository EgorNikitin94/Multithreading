//
//  PostViewCoordinator.swift
//  Navigation
//
//  Created by Егор Никитин on 13.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class PostViewCoordinator: BaseCoordinator {
    
    weak var parentCoordinator: BaseCoordinator?
    
    var navigator: UINavigationController
    
    var childCoordinators: [BaseCoordinator] = []
    
    init(controller: UINavigationController, parent: BaseCoordinator) {
        self.navigator = controller
        self.parentCoordinator = parent
    }
    
    func start() {
        let postViewController = PostViewController()
        postViewController.coordinator = self
        navigator.pushViewController(postViewController, animated: true)
    }
    
    func showNextViewController() {
        let infoViewCoordinator = InfoViewCoordinator(controller: navigator, parent: self)
        infoViewCoordinator.navigator = navigator
        childCoordinators.append(infoViewCoordinator)
        infoViewCoordinator.start()
    }
    
    func childDidFinish(_ child: BaseCoordinator?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
    
    func didFinishCoordinator() {
        parentCoordinator?.childDidFinish(self)
    }

}

