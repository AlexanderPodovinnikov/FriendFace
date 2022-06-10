//
//  ContentView.swift
//  FriendFace
//
//  Created by Alex Po on 29.05.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor<CachedUser>(\.isActive, order: .reverse), SortDescriptor(\.name)], predicate: nil) var users: FetchedResults<CachedUser>
    @State public var loadedUsers = [User]()
    
    let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink {
                    DetailsView(user: user)
                } label: {
                    HStack {
                        Text(user.wrappedName)
                        Spacer()
                        Image(systemName: user.isActive ? "person.crop.circle.badge.checkmark" : "person.crop.circle.badge.xmark")
                            .foregroundColor(user.isActive ? .green : .red)
                    }
                }
            }
            .onAppear().task() {
                await loadData()
            }
            .navigationTitle("FriendFace")
            
            Text("Welcome")
        }
    }
    
    func loadData() async {
        if !loadedUsers.isEmpty { return }
        
        print("Hello")
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let decoded = try? decoder.decode([User].self, from: data) {
                loadedUsers = decoded
                print("Loaded \(loadedUsers.count) records")
                
                await MainActor.run() {
                    for user in loadedUsers {
                        let newUser = CachedUser(context: moc)
                        newUser.id = user.id
                        newUser.name = user.name
                        newUser.age = user.age
                        newUser.about = user.about
                        newUser.company = user.company
                        newUser.address = user.address
                        newUser.email = user.email
                        newUser.registered = user.registered
                        newUser.isActive = user.isActive
                        newUser.tags = user.tags.joined(separator: ",")
                        
                        for friend in user.friends {
                            let newFriend = CachedFriend(context: moc)
                            newFriend.id = friend.id
                            newFriend.name = friend.name
                            newUser.addToFriends(newFriend)
                        }
                    }
                    if moc.hasChanges {
                        try? moc.save()
                        print("Database updated")
                    } else {
                        print("Nothing new")
                    }
                }
            } else {
                print("WTF???")
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
