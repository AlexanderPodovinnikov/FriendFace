//
//  CachedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Alex Po on 10.06.2022.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var friendOf: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }
    
    convenience init(friend: Friend, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = friend.id
        self.name = friend.name
    }

}

// MARK: Generated accessors for friendOf
extension CachedFriend {

    @objc(addFriendOfObject:)
    @NSManaged public func addToFriendOf(_ value: CachedUser)

    @objc(removeFriendOfObject:)
    @NSManaged public func removeFromFriendOf(_ value: CachedUser)

    @objc(addFriendOf:)
    @NSManaged public func addToFriendOf(_ values: NSSet)

    @objc(removeFriendOf:)
    @NSManaged public func removeFromFriendOf(_ values: NSSet)

}

extension CachedFriend : Identifiable {

}
