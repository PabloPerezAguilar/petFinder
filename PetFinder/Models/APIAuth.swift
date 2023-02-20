//
//  APIAuth.swift
//  PetFinder
//
//  Created by Consultant on 1/24/23.
//

import Foundation

struct APIToken: Codable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
    }
}
