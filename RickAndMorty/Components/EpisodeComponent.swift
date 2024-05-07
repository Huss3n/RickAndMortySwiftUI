//
//  EpisodesView.swift
//  RickAndMorty
//
//  Created by Muktar Hussein on 03/05/2024.
//

import SwiftUI

struct EpisodeComponent: View {
    var episode: String
    var episodeName: String
    var airdate: String
    var maxWidth: CGFloat = .infinity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(episode)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(episodeName)
                .font(.headline)
            
            Text(airdate)
                .font(.callout)
                .foregroundStyle(Color(.systemGray))
            
        }
        .padding(.horizontal, 10)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .frame(width: 150, height: 90)
        .frame(maxWidth: maxWidth, alignment: .leading)
        .padding(.leading, 6)
        .overlay {
            RoundedRectangle(cornerRadius: 25.0)
                .stroke(Color.primary, lineWidth: 1.0)
        }
        
    }
}

#Preview {
    EpisodeComponent(episode: "Episode 01", episodeName: "Pilot", airdate: "2024")
}
