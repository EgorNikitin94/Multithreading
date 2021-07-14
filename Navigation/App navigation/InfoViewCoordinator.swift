//
//  InfoViewCoordinator.swift
//  Navigation
//
//  Created by Егор Никитин on 13.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class InfoViewCoordinator: BaseCoordinator {
    
    weak var parentCoordinator: BaseCoordinator?
    
    var navigator: UINavigationController
    
    var childCoordinators: [BaseCoordinator] = []
    
    init(controller: UINavigationController, parent: BaseCoordinator) {
        self.navigator = controller
        self.parentCoordinator = parent
    }
    
    func start() {
        let infoViewController = InfoViewController()
        infoViewController.coordinator = self
        navigator.present(infoViewController, animated: true, completion: nil)
    }
    
    func showNextViewController() {

    }
    
    func childDidFinish(_ child: BaseCoordinator?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
    
    func didFinishCoordinator() {
        parentCoordinator?.childDidFinish(self)
    }

}

