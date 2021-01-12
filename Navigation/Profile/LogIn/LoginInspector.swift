//
//  LoginInspector.swift
//  Navigation
//
//  Created by Егор Никитин on 07.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {
    
    func logInChecker(textFieldLogIn: String, completion: () -> Void) {
        let checkerLogIn = Checker.shared.check(textFieldLogIn)
        if checkerLogIn == true {
            print("logIn: OK")
            completion()
        } else {
            print("logIn: try once more")
        }
    }
    
    func passwordChecker(textFieldPassword: String, completion: () -> Void) {
        let checkerPassword = Checker.shared.check(textFieldPassword)
        if checkerPassword == true {
            print("password: OK")
            completion()
        } else {
            print("password: try once more")
        }
    }
    
}

