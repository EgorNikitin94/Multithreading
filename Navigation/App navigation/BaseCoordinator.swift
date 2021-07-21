//
//  BaseCoordinator.swift
//  Navigation
//
//  Created by Егор Никитин on 14.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

@objc protocol BaseCoordinator: class {
    var navigator : UINavigationController { get set }
    var childCoordinators: [BaseCoordinator] { get set }
    
    func start()
    func childDidFinish(_ child: BaseCoordinator?)
    func showNextViewController()
    func didFinishCoordinator()
    @objc optional func showPost(number: Int)
}
