//
//  Response.swift
//  FriendFace
//
//  Created by Alex Po on 29.05.2022.
//

import Foundation

struct Friend: Identifiable, Codable {
    let id: UUID
    let name: String
}


struct User: Identifiable, Codable {
    let id: UUID
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
    
    static var example: [User] {
    
        let idOne = UUID()
        let idTwo = UUID()
    
    return [
        User(id: idOne,
             isActive: true,
             name: "Tony Stark",
             age: 45, company: "Avengers",
             email: "tony@avengers.com",
             address: "Marvell Cinematic Universe ",
             about: "A fictional character primarily portrayed by Robert Downey Jr. in the Marvel Cinematic Universe (MCU) media franchise—based on the Marvel Comics character of the same name—commonly known by his alias, Iron Man. Stark is initially depicted as an industrialist, genius inventor, and playboy who is CEO of Stark Industries. Initially the chief weapons manufacturer for the U.S. military, he has a change of heart and redirects his technical knowledge into the creation of mechanized suits of armor which he uses to defend against those that would threaten peace around the world. He becomes a founding member and leader of the Avengers.",
             registered: Date(),
             tags: ["leader","weapon","playboy"],
             friends: [
                Friend(id: idTwo, name: "Amy Shark")
             ]
            ),
        
        User(id: idTwo,
             isActive: false,
             name: "Amy Shark",
             age: 21, company: "self-employed",
             email: "amy@ajax.com",
             address: "Nea Peramos 89, 12345, Greece",
             about: "I'm an attorney by day, and in my spare time, I'm writing my first novel. Training for the next marathon is my go-to stress relief. I'm an avid reader of the Economist and the Atlantic. I keep up-to-date with politics but try to stay out of the drama. Early morning meditation is my spiritual practice.",
             registered: Date(),
             tags: ["attorney","marathon","meditation"],
             friends: [
                Friend(id: idOne, name: "Tony Stark")
             ]
            )
    ]
    }
}

