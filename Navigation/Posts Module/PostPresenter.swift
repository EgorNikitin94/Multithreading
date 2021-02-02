//
//  PostPresenter.swift
//  Navigation
//
//  Created by Егор Никитин on 09.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol FeedViewOutput {
    var navigationController: UINavigationController? { get set }
    func showPost()
}

class PostPresenter: FeedViewOutput {
    
    var navigationController: UINavigationController?
    
    func showPost() {
        let postViewController = PostViewController()
        
        navigationController?.pushViewController(postViewController, animated: true)
        
    }
    
    
}
