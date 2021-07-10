//
//  User.swift
//  Navigation
//
//  Created by Егор Никитин on 08.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

final class User {
    
    let id: String
    let email: String
    let password: String
    
    init(id: String, email: String, password: String) {
        self.id = id
        self.email = email
        self.password = password
    }
}
