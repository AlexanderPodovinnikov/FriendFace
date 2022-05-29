//
//  Response.swift
//  FriendFace
//
//  Created by Alex Po on 29.05.2022.
//

import Foundation

struct Friend: Codable {
    let id: String
    let name: String
}


struct User: Codable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}

struct Response: Codable {
    let users: [User]
}
