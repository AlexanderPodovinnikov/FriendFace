//
//  ContentView.swift
//  FriendFace
//
//  Created by Alex Po on 29.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
    
    var body: some View {
        NavigationView {
            List(users, id: \.name) { user in
                HStack {
                    Text(user.name)
                    Spacer()
                    Image(systemName: user.isActive ? "person.crop.circle.badge.checkmark" : "person.crop.circle.badge.xmark")
                        .foregroundColor(user.isActive ? .green : .red)
                }
            }
            .task() {
                await loadData()
            }
            .navigationTitle("FriendFace")
            
            Text("Welcome")
        }
        
    }
    
    func loadData() async {
        
        print("Hello")
        if !users.isEmpty { return }
        
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
        ContentView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
