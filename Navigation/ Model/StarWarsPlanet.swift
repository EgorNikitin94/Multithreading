//
//  StarWarsPlanet.swift
//  Navigation
//
//  Created by Егор Никитин on 16.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct StarWarsPlanet: Decodable {
    
    let name: String
    let orbitalPeriod: String
    var residents: [String]
    
    enum CodingKeys: String, CodingKey {
            case name
            case orbitalPeriod = "orbital_period"
            case residents
        }
    
    init(data: Data) throws {
            self = try JSONDecoder().decode(StarWarsPlanet.self, from: data)
        }
}
