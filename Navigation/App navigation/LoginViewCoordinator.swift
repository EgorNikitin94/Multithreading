//
//  LoginViewCoordinator.swift
//  Navigation
//
//  Created by Егор Никитин on 13.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class LoginViewCoordinator: BaseCoordinator {
    
    weak var parentCoordinator: BaseCoordinator?
    
    var navigator: UINavigationController
    
    var childCoordinators: [BaseCoordinator] = []
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func start() {
        navigator.tabBarItem.image = UIImage(named: "person")
        
        navigator.tabBarItem.title = LocalizableStrings.profile.rawValue.localize()
    }
    
    func showNextViewController() {
        let profileViewCoordinator = ProfileViewCoordinator(controller: navigator, parent: self)
        childCoordinators.append(profileViewCoordinator)
        profileViewCoordinator.start()
    }
    
    func childDidFinish(_ child: BaseCoordinator?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
    
    func didFinishCoordinator() {
        parentCoordinator?.childDidFinish(self)
    }
    
}

