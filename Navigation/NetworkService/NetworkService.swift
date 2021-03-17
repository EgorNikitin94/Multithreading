//
//  NetworkService.swift
//  Navigation
//
//  Created by Егор Никитин on 13.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct NetworkService {
    
    static let session = URLSession.shared
    
    static func dataTask(url: URL, completion: @escaping (Data?) -> Void) {
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print(httpResponse.statusCode)
            print(httpResponse.allHeaderFields)
            
            if let data = data {
                completion(data)
            }
        }
        task.resume()
    }
    
    static func toObject(json: Data) throws -> Dictionary<String, Any>? {
        return try JSONSerialization.jsonObject(with: json, options: .mutableContainers) as? [String: Any]
    }
    
    static func toData(dictionary: Dictionary<String, Any>) throws -> Data {
        return try JSONSerialization.data(withJSONObject: dictionary, options: .fragmentsAllowed)
    }
}
