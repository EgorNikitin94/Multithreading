//
//  CoordinatorsFactory.swift
//  Navigation
//
//  Created by Егор Никитин on 14.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

struct CoordinatorsFactory {
    
    static func makeChildCoordinator(navigator: UINavigationController) -> ChildCoordinator {
        let coordinator = ChildCoordinator(navigator: navigator)
        AppCoordinator.shared.childCoordinators?.append(coordinator)
        return coordinator
    }
    
}
