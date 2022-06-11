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
            Section {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(user.wrappedTags, id: \.self) {
                                Text($0)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .padding(3)
                                    .background(.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
                }
                
            } header: {
                Text("Tags")
            }
        }
        .listStyle(.grouped)
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct DetailsView_Previews: PreviewProvider {
//    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//
//    static var previews: some View {
//        return NavigationView {
//            DetailsView(user: CachedUser(user: User.example[0], context: moc))
//        }
//    }
//}
