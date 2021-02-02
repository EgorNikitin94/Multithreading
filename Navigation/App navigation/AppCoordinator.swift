//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Егор Никитин on 11.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit


class AppCoordinator {
    
    let navigator: UINavigationController
    
    let rootTabBarController = TabBarViewController.shared
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }

}
