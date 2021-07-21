//
//  PhotosViewCoordinator.swift
//  Navigation
//
//  Created by Егор Никитин on 13.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//


import UIKit

final class PhotosViewCoordinator: BaseCoordinator {
    
    weak var parentCoordinator: BaseCoordinator?
    
    var navigator: UINavigationController
    
    var childCoordinators: [BaseCoordinator] = []
    
    init(controller: UINavigationController, parent: BaseCoordinator) {
        self.navigator = controller
        self.parentCoordinator = parent
    }
    
    func start() {
        let photosViewController = PhotosViewController()
        photosViewController.coordinator = self
        navigator.pushViewController(photosViewController, animated: true)
    }
    
    func showNextViewController() {
        //
    }
    
    func childDidFinish(_ child: BaseCoordinator?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
    
    func didFinishCoordinator() {
        parentCoordinator?.childDidFinish(self)
    }
    
}
