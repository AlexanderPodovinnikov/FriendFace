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
        VStack(alignment: .leading) {
            Text(user.name)
                .font(.title)
            HStack {
                Text("Age: \(user.age), ")
                Text("Company: \(user.company)")
            }
            .font(.headline)
            .padding([.top, .bottom])
            
            Text(user.about)
                .font(.subheadline)
            Text("Friends:")
                .font(.headline)
                .padding(.top)
            ScrollView {
                ForEach(user.friends, id:\.id) {
                    Text($0.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding()
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(user: User.example[0])
    }
}
