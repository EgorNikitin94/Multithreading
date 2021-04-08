//
//  LoginInspector.swift
//  Navigation
//
//  Created by Егор Никитин on 07.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class CachedUser: Object {
    dynamic var id: String?
    dynamic var email: String?
    dynamic var password: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


final class LoginInspector: LoginViewControllerDelegate {
    
    
    private var realm: Realm? {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var config = Realm.Configuration()
        config.fileURL = documentsPath.appendingPathComponent("users.realm")
        return try? Realm(configuration: config)
    }
    
    func createUser(user: User, completion: @escaping (Bool) -> Void) {
        let cachedUser = CachedUser()
        cachedUser.id = user.id
        cachedUser.email = user.email
        cachedUser.password = user.password
        do{
            try realm?.write {
                realm?.add(cachedUser)
            }
            completion(true)
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
        
            
    }
    
    func checkUser(completion: @escaping (Bool, String?) -> Void) {
        let users = getUsers()
        if users.isEmpty {
            completion(false, nil)
        } else {
            completion(true, users.first?.email)
        }
    }
    
    private func getUsers() -> [User] {
        return realm?.objects(CachedUser.self).compactMap {
            guard let id = $0.id, let email = $0.email, let password = $0.password else { return nil }
            return User(id: id, email: email, password: password)
        } ?? []
    }
    
    
}
