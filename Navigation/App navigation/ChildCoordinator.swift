//
//  childCoordinator.swift
//  Navigation
//
//  Created by Егор Никитин on 13.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class ChildCoordinator: BaseCoordinator {
    
    var childCoordinators: [BaseCoordinator]? = nil
    
    let navigator: UINavigationController
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func push(viewController: UIViewController) {
        navigator.pushViewController(viewController, animated: true)
    }
    func pop() {
        navigator.popViewController(animated: true)
    }
    
    func present(viewController: UIViewController) {
        navigator.present(viewController, animated: true, completion: nil)
    }
    
    func dismiss() {
        navigator.dismiss(animated: true, completion: nil)
    }
    
    func makeProfileModule(coordinator: ChildCoordinator) {
        let viewModel = ProfileViewModel()
        let profileViewController = ProfileViewController(coordinator: coordinator, viewModel: viewModel)
        coordinator.push(viewController: profileViewController)
    }
    
}

