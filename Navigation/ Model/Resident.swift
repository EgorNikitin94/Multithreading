//
//  Resident.swift
//  Navigation
//
//  Created by Егор Никитин on 17.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct Resident: Decodable {
    
    let name: String
    
    init(data: Data) throws {
            self = try JSONDecoder().decode(Resident.self, from: data)
        }
}
