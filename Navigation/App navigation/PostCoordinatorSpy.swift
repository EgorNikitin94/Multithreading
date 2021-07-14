//
//  PostCoordinatorSpy.swift
//  Navigation
//
//  Created by Егор Никитин on 14.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class PostCoordinatorSpy: BaseCoordinator {
    
    var navigator: UINavigationController
    
    var childCoordinators: [BaseCoordinator] = []
    
    private(set) var isCalledCoordinatorStart = false
    
    private(set) var postNumber = -1
    
    private(set) var post: Post!
    
    private(set) var isCalledShowNextViewController = false
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func start() {
        isCalledCoordinatorStart = true
    }
    
    func showPost(number: Int) {
        postNumber = number
        post = Storage.news[number]
    }
    
    func showPostInfo() {
        isCalledShowNextViewController = true
    }

    func childDidFinish(_ child: BaseCoordinator?) {
        //
    }
    
    func showNextViewController() {
        //
    }
    
    func didFinishCoordinator() {
        //
    }
}
