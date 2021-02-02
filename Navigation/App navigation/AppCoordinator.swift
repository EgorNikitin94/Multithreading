//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Егор Никитин on 11.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol BaseCoordinator {
    var childCoordinators: [BaseCoordinator]? { get set }

}

final class AppCoordinator: BaseCoordinator {
    
    static let shared = AppCoordinator()
    
    var childCoordinators: [BaseCoordinator]?
    
    let rootController: TabBarViewController = TabBarViewController()
    
    private init() {}
    
}
