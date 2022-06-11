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
    
    let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink {
                    DetailsView(user: user)
                } label: {
                    HStack {
                        Image(systemName: user.isActive ? "person.crop.circle.badge.checkmark" : "person.crop.circle.badge.xmark")
                            .foregroundColor(user.isActive ? .green : .red)
                        Text(user.wrappedName)
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
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let decoded = try? decoder.decode([User].self, from: data) { //!
                let loadedUsers = decoded
                print("Loaded \(loadedUsers.count) records")
                
                await MainActor.run() {
                    updateDatabase(with: loadedUsers)
                }
            } else {
                print("WTF???")
            }
        } catch {
            print("Invalid data")
        }
    }
    
    func updateDatabase(with users: [User]) {
        for user in users {
            let _ = CachedUser(user: user, context: moc)
        }
        if moc.hasChanges {
            try? moc.save()
            print("Database updated")
        } else {
            print("Nothing new")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
