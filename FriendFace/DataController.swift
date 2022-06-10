//
//  DataController.swift
//  FriendFace
//
//  Created by Alex Po on 10.06.2022.
//

import Foundation
import CoreData


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CachedUsers")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            
            // merge policy for duplicates
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
