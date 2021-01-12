//
//  Checker.swift
//  Navigation
//
//  Created by Егор Никитин on 07.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class Checker {
    
    static let shared = Checker()
    
    private let logIn = "EgorNikitin@gmail.com"
    private let password = "1234567890"
    
    private init() {}
    
    func check(_ textFieldText: String) -> Bool {
        if textFieldText == logIn || textFieldText == password {
            print("true")
            return true
        } else {
            print("not true")
            return false
        }
    }
    
}
