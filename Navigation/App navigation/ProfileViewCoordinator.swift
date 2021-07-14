//
//  ProfileViewCoordinator.swift
//  Navigation
//
//  Created by Егор Никитин on 13.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class ProfileViewCoordinator: BaseCoordinator {
    
    weak var parentCoordinator: BaseCoordinator?
    
    var navigator: UINavigationController
    
    var childCoordinators: [BaseCoordinator] = []
    
    init(controller: UINavigationController, parent: BaseCoordinator) {
        self.navigator = controller
        self.parentCoordinator = parent
    }
    
    func start() {
        let viewModel = ProfileViewModel()
        let profileViewController = ProfileViewController(viewModel: viewModel)
        profileViewController.coordinator = self
        navigator.pushViewController(profileViewController, animated: true)
    }
    
    func showNextViewController() {
        let photosViewCoordinator = PhotosViewCoordinator(controller: navigator, parent: self)
        childCoordinators.append(photosViewCoordinator)
        photosViewCoordinator.start()
    }
    
    func childDidFinish(_ child: BaseCoordinator?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
    
    func didFinishCoordinator() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func showPost(number: Int) {
        print("Open post detail: №\(number) with model \(Storage.news[number])")
    }
    
}
