//
//  DetailsView.swift
//  FriendFace
//
//  Created by Alex Po on 30.05.2022.
//

import SwiftUI
import CoreData

struct DetailsView: View {
    var user: CachedUser
    
    var body: some View {
        List {
            Section {
            Text(user.wrappedAbout)
                .font(.subheadline)
                .padding(.vertical)
            } header: {
                Text("About")
            }
            
            Section {
                HStack {
                    Text("Age: \(user.age), Company: \(user.wrappedCompany)")
                }
                Text("Address: \(user.wrappedAddress)")
            } header: {
                Text("Details")
            }
                
            Section {
                ForEach(user.wrappedFriends) {
                    Text($0.wrappedName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            } header: {
                Text("Friends")
            }
        }
        .listStyle(.grouped)
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let user = CachedUser(context: moc)
        user.name = "Sample Samloff"
        user.about = "This is sample user for previews"
        user.age = 19
        user.address = "Sv Nedelia 101 Sofia BG"
                
        return NavigationView {
            DetailsView(user: user)
        }
    }
}
