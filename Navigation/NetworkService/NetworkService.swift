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
    
    static func dataTask(url: URL, completion: @escaping (String?) -> Void) {
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print(httpResponse.statusCode)
            print(httpResponse.allHeaderFields)
            
            if let data = data {
                completion(String(data: data, encoding: .utf8))
            }
        }
        task.resume()
    }
}
