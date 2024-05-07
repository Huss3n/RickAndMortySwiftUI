//
//  DetailComponent.swift
//  RickAndMorty
//
//  Created by Muktar Hussein on 02/05/2024.
//

import SwiftUI

struct DetailComponent: View {
    var imageName: String
    var detailText: String
    var characterText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom, spacing: 10) {
                Image(systemName: imageName)
                Text(characterText)
            }
            .imageScale(.medium)
            

            
            VStack {
                Text(detailText)
            }
//            .background(.gray.opacity(0.2))
            .frame(maxWidth: .infinity, alignment: .center)
            .background(.gray.opacity(0.2))
            .padding(.top, 32)
        }
        .padding()
        .frame(width: 100, height: 100)
        .background(
            Rectangle()
                .stroke(lineWidth: 1.0)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    DetailComponent(
        imageName: "person.fill",
        detailText: "Status",
        characterText: "Alive"
    )
}
