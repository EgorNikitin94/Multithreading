//
//  NavigationTests.swift
//  NavigationTests
//
//  Created by Егор Никитин on 11.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import XCTest
@testable import Navigation

class NavigationTests: XCTestCase {
    
    var profileViewCoordinator: ProfileViewCoordinator!
    
    var post: Post!
    
    var postNumber = 0
    
    override func setUp() {
        super.setUp()
        profileViewCoordinator = ProfileViewCoordinator(controller: UINavigationController(), parent: LoginViewCoordinator(navigator: UINavigationController()))
        post = Post(author: "Apple News", description: "Apple представила новые Mac на собственном процессоре M1", image: "Macbook", likes: 9999, views: 99999)
    }
    
    override func tearDown() {
        profileViewCoordinator = nil
        super.tearDown()
    }
    
    func test_coordinator_start() {
        profileViewCoordinator.start()
        XCTAssertTrue(profileViewCoordinator.isCalledCoordinatorStart, "Not started coordinator")
    }
    
    func test_coordinator_show_post() {
        profileViewCoordinator.showPost(number: postNumber)
        XCTAssertEqual(profileViewCoordinator.postNumber, postNumber)
        XCTAssertEqual(profileViewCoordinator.post.author, post.author)
        XCTAssertEqual(profileViewCoordinator.post.description, post.description)
        XCTAssertEqual(profileViewCoordinator.post.likes, post.likes)
        XCTAssertEqual(profileViewCoordinator.post.views, post.views)
    }
    
    func test_coordinator_show_post_info() {
        profileViewCoordinator.showPostInfo()
        XCTAssertTrue(profileViewCoordinator.isCalledShowNextViewController, "Not called showNextViewController")
    }

}
