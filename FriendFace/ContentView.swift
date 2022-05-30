//
//  ContentView.swift
//  FriendFace
//
//  Created by Alex Po on 29.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User]
    
    let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink {
                    DetailsView(user: user)
                } label: {
                    HStack {
                        Text(user.name)
                        Spacer()
                        Image(systemName: user.isActive ? "person.crop.circle.badge.checkmark" : "person.crop.circle.badge.xmark")
                            .foregroundColor(user.isActive ? .green : .red)
                    }
                }
            }
            .task() {
                if users.isEmpty {
                    await loadData()
                }
            }
            .navigationTitle("FriendFace")
            
            Text("Welcome")
        }
    }
    
    init(users: [User] = [User]()) {
        self.users = users
    }
    
    func loadData() async {
        
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
                users = decoded
                print("Loaded \(users.count) records")
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
        ContentView(users: User.example)
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
