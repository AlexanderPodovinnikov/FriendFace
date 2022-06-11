//
//  CachedUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Alex Po on 10.06.2022.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }
    public var wrappedCompany: String {
        company ?? "Unknown company"
    }
    public var wrappedAddress: String {
        address ?? "Unknown address"
    }
    public var wrappedAbout: String {
        about ?? "No information"
    }
    public var wrappedTags: [String] {
        let tagsString = (tags ?? "n/a")
        return tagsString.components(separatedBy: ",")
    }
    public var wrappedFriends: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    convenience init(user: User, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = user.id
        self.name = user.name
        self.age = user.age
        self.about = user.about
        self.company = user.company
        self.address = user.address
        self.email = user.email
        self.registered = user.registered
        self.isActive = user.isActive
        self.tags = user.tags.joined(separator: ",")
        
        for friend in user.friends {
            let newFriend = CachedFriend(friend: friend, context: context)
            self.addToFriends(newFriend)
        }
    }

}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
