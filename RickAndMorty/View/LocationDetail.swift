//
//  LocationDetail.swift
//  RickAndMorty
//
//  Created by Muktar Hussein on 07/05/2024.
//

import SwiftUI
import Combine

struct LocationDetail: View {
    @StateObject private var episodeVM = EpisodeDetailVM()
    var locationName: String = "Earth"
    var locationType: String = "Planet"
    var locationDimension: String = "Dimension C-137"
    var residents: [String] = [""]
    var url: String = ""
    var created: String = ""
    @State private var fetchedResidents: [Characters] = []
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    locationMoment(firstText: "Name", secondText: locationName)
                    locationMoment(firstText: "Type", secondText: locationType)
                    locationMoment(firstText: "Dimension", secondText: locationDimension)
                    
                    Text("Residents")
                        .font(.title.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    Divider()
                    
                    LazyVGrid(columns: columns) {
                        ForEach(episodeVM.fetchedCharacters) { character in
                            NavigationLink {
                                CharacterDetails(characterID: character.id, characterName: character.name)
                            } label: {
                                Character(url: character.image, name: character.name, status: character.status)
                                    .padding(.horizontal, 3)
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                    .padding(.top)
                }
                .onAppear {
                    fetchDataForResidents()
                }
            }
            .navigationTitle(locationName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func fetchDataForResidents() {
        // Use a set to store unique URLs and avoid duplicates
        var uniqueCharacterUrls = Set<String>()
        for resident in residents {
            if !uniqueCharacterUrls.contains(resident) {
                uniqueCharacterUrls.insert(resident)
//                print("Fetching resident data for URL: \(resident)")
                episodeVM.fetchCharacters(fromURL: resident)
            }
        }
    }
    
    private func locationMoment(firstText: String, secondText: String) -> some View {
        HStack {
            Text(firstText)
            Spacer()
            
            Text(secondText)
        }
        .frame(height: 25)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(lineWidth: 0.5)
        }
        .background(
            RoundedRectangle(cornerRadius: 10.0)
                .fill(.gray.opacity(0.2))
        )
        .padding(.horizontal, 8)
    }
}

#Preview {
    LocationDetail()
}
