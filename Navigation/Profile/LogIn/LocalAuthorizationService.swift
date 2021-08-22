//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Егор Никитин on 21.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import LocalAuthentication

protocol LocalAuthorizationServiceProtocol {
    func authorizePossible(_ authorizationFinished: @escaping (Bool) -> Void)
}

final class LocalAuthorizationService: LocalAuthorizationServiceProtocol {
    
    let laContext = LAContext()
    
    var error: NSError?
    
    func authorizePossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        let canAuthorize = laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if canAuthorize {
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To access data") { success, error in
                if let error = error {
                    print("Try another method, \(error.localizedDescription)")
                    return
                }
                authorizationFinished(success)
            }
        } else {
            authorizationFinished(false)
        }
    }
}
