//
//  NavigationTests.swift
//  NavigationTests
//
//  Created by Егор Никитин on 11.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import XCTest

class NavigationTests: XCTestCase {
    
    var postViewCoordinatorSpy: PostCoordinatorSpy!
    
    var post: Post!
    
    var postNumber = 0
    
    override func setUp() {
        super.setUp()
        postViewCoordinatorSpy = PostCoordinatorSpy(navigator: UINavigationController())
        post = Post(author: "Apple News", description: "Apple представила новые Mac на собственном процессоре M1", image: "Macbook", likes: 9999, views: 99999)
    }
    
    override func tearDown() {
        postViewCoordinatorSpy = nil
        super.tearDown()
    }
    
    func test_coordinator_start() {
        postViewCoordinatorSpy.start()
        XCTAssertTrue(postViewCoordinatorSpy.isCalledCoordinatorStart, "Not started coordinator")
    }
    
    func test_coordinator_show_post() {
        postViewCoordinatorSpy.showPost(number: postNumber)
        XCTAssertEqual(postViewCoordinatorSpy.postNumber, postNumber)
        XCTAssertEqual(postViewCoordinatorSpy.post.author, post.author)
        XCTAssertEqual(postViewCoordinatorSpy.post.description, post.description)
        XCTAssertEqual(postViewCoordinatorSpy.post.likes, post.likes)
        XCTAssertEqual(postViewCoordinatorSpy.post.views, post.views)
    }
    
    func test_coordinator_show_post_info() {
        postViewCoordinatorSpy.showPostInfo()
        XCTAssertTrue(postViewCoordinatorSpy.isCalledShowNextViewController, "Not called showNextViewController")
    }

}
