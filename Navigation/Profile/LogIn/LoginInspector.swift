//
//  LoginInspector.swift
//  Navigation
//
//  Created by Егор Никитин on 07.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import FirebaseAuth

final class LoginInspector: LoginViewControllerDelegate {
    
    func checkUser(userEmail: String, userPassword: String, completion: @escaping (Bool) -> Void) {
        
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (authData, error) in
            
            if error != nil {
                print(error.debugDescription)
            }
            
            if authData == nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func createUser(userEmail: String, userPassword: String, completion: @escaping (Bool) -> Void) {
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (authData, error) in
            
            if error != nil {
                print(error.debugDescription)
            }
            
            if authData == nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func signOutUser(completion: @escaping (Error?) -> Void) {
        if Auth.auth().currentUser != nil {
            do {
              try FirebaseAuth.Auth.auth().signOut()
            } catch let signOutError {
                print (signOutError.localizedDescription)
                completion(signOutError)
            }
        }
    }
    
}
