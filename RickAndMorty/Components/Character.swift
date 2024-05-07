//
//  Character.swift
//  RickAndMorty
//
//  Created by Muktar Hussein on 28/04/2024.
//

import SwiftUI

struct Character: View {
    
    var url: String
    var name: String
    var status: Status
    
//    let urlString: URL = URL(string: "https://picsum.photos/400")!
    
    var body: some View {
        VStack( alignment: .leading, spacing: 10) {
                VStack {
                    if let url = URL(string: url) {
                        ImageLoader(url: url)
                    }
                }
                .frame(height: 200)
            
                Text(name)
                    .font(.title2)
                    .bold()
                    .lineLimit(1)
                HStack {
                    Text("Status: \(status)")
                }
                .foregroundStyle(.secondary)
                .font(.headline)
        }
    }
}

#Preview {
    Character(url: "", name: "name", status: .alive)
        .padding()
}



