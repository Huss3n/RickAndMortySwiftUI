//
//  EpisodeView.swift
//  RickAndMorty
//
//  Created by Muktar Hussein on 06/05/2024.
//

import SwiftUI

struct EpisodeView: View {
    @StateObject private var episodes = EpisodeService()
    
    var body: some View {
        NavigationStack {
            ZStack {
//                Color.red.ignoresSafeArea()
                
                ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(episodes.allEpisodes) { episode in
                                NavigationLink {
                                    EpisodeDetail(
                                        episodeName: episode.name,
                                        airDate: episode.airDate,
                                        episode: episode.episode,
                                        created: episode.created,
                                        characters: episode.characters
                                    )
                                } label: {
                                    EpisodeComponent(
                                        episode: episode.episode,
                                        episodeName: episode.name,
                                        airdate: episode.airDate
                                    )
                                }
                                .foregroundStyle(.primary)

                            }
                        }
                        .padding(.horizontal, 4)
                        .navigationTitle("Episodes")
                }
            }
        }
    }
}

#Preview {
    EpisodeView()
}
