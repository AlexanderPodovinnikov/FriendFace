//
//  DetailsView.swift
//  FriendFace
//
//  Created by Alex Po on 30.05.2022.
//

import SwiftUI

struct DetailsView: View {
    var user: User
    
    
    var body: some View {
        List {
            Section {
            Text(user.about)
                .font(.subheadline)
                .padding(.vertical)
            } header: {
                Text("About")
            }
            
            Section {
                HStack {
                    Text("Age: \(user.age), Company: \(user.company)")
                }
                Text("Address: \(user.address)")
            } header: {
                Text("Details")
            }
                
            Section {
                ForEach(user.friends) {
                    Text($0.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            } header: {
                Text("Friends")
            }
        }
        .listStyle(.grouped)
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(user: User.example[0])
    }
}
