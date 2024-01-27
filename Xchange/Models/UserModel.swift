//
//  UserModel.swift
//  Xchange
//
//  Created by Sania Sinha on 1/27/24.
//

import Foundation

struct UserModel: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    // Add other properties as needed
}
