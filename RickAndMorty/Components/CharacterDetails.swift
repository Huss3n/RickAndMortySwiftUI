//
//  CharacterDetails.swift
//  RickAndMorty
//
//  Created by Muktar Hussein on 02/05/2024.
//

import SwiftUI
import SDWebImageSwiftUI


struct CharacterDetails: View {
    @StateObject private var characters = CharacterService()
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    
    let characterID: Int
    let characterName: String
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    if characters.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        if let character = characters.returnedCharacter {
                            if let url = URL(string: character.image) {
                                RoundedRectangle(cornerRadius: 25)
                                    .frame(height: 200)
                                    .frame(maxWidth: .infinity)
                                    .overlay {
                                        WebImage(url: url)
                                            .resizable()
                                        //                                            .scaledToFit()
                                    }
                                    .clipped()
                            }
                            
                            Text(character.name)
                                .font(.title2.bold())
                            
                            HStack {
                                if character.status.rawValue == "Alive" {
                                    Image(systemName: "heart.fill")
                                    Text("Status")
                                    Text(character.status.rawValue)
                                        .font(.headline)
                                }else if character.status.rawValue == "Dead"{
                                    Image(systemName: "heart.slash.fill")
                                    Text(character.status.rawValue)
                                        .font(.headline)
                                }else {
                                    Image(systemName: "camera.metering.unknown")
                                    Text(character.status.rawValue)
                                        .font(.headline)
                                }
                            }
                            .imageScale(.large)
                            
                            HStack {
                                Image(systemName: "person.fill")
                                    .imageScale(.large)
                                Text("Gender")
                                
                                Text(character.gender.rawValue)
                                    .font(.headline)
                            }
                            .imageScale(.large)
                            
                            HStack {
                                Image(systemName: "pin")
                                    .imageScale(.large)
                                
                                Text("Location")
                                Text(character.location.name)
                                    .font(.headline)
                                    .lineLimit(1)
                            }
                            .imageScale(.large)
                            
                            HStack {
                                Image(systemName: "paperplane")
                                    .imageScale(.large)
                                Text("Origin")
                                
                                Text(character.origin.name)
                                    .font(.headline)
                            }
                            .imageScale(.large)
                            
                            HStack {
                                Image(systemName: "globe")
                                    .imageScale(.large)
                                Text("Species")
                                
                                Text(character.species)
                                    .font(.headline)
                            }
                            .imageScale(.large)
                            
                            HStack {
                                Image(systemName: "calendar")
                                    .imageScale(.large)
                                Text("Date Created")
                                
                                Text(character.created)
                                    .font(.headline)
                                    .lineLimit(1)
                            }
                            .imageScale(.large)
                            
                            Divider()
                            
                            Text("Episodes")
                                .font(.title.bold())
                            
                            ScrollView(.horizontal) {
                                LazyHStack(spacing: 8) {
                                    if characters.isCharactersFetched {
                                        ProgressView()
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    } else {
                                        ForEach(characters.episodes) { episode in
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
                                        }
                                        .foregroundStyle(.primary)
                                    }
                                }
                            }
                            .scrollIndicators(.hidden)
                            
                        }
                    }
                    .padding(.horizontal, 8)
                }
                .onAppear {

                        characters.getSingleCharacter(characterID: characterID)
                    
                }
                .navigationTitle(characterName)
                .navigationBarTitleDisplayMode(.inline)
            }
            .ignoresSafeArea(edges: .bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(8)
        }
    }
}

#Preview {
    CharacterDetails(characterID: 1, characterName: "Rick")
}
