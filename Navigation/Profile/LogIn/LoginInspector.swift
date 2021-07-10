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
        let config = Realm.Configuration(fileURL: documentsPath.appendingPathComponent("users.realm"), encryptionKey: getKey())
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
    
    private func getKey() -> Data {
  
        let keychainIdentifier = "io.Realm.EncryptionExampleKey"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!

        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]
        
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            return dataTypeRef as! Data
        }
        
        var key = Data(count: 64)
        key.withUnsafeMutableBytes({ (pointer: UnsafeMutableRawBufferPointer) in
            let result = SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
            assert(result == 0, "Failed to get random bytes")
        })
        
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: key as AnyObject
        ]
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
        return key
    }
    
}
