//
//  HomeView.swift
//  RickAndMorty
//
//  Created by Muktar Hussein on 20/11/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var charactersVm = CharacterService()
    @State private var searchText: String = ""
    @State private var showFilter: Bool = false
    @State private var filteredCharacters: [Characters] = []
    @State private var selectedFilter: Filters = .all
    @State private var noResultsFound: Bool = false
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                if selectedFilter.rawValue != "All" {
                    Text("Sorting by: \(selectedFilter.rawValue)")
                        .font(.headline)
                }
                
                VStack {
                    if noResultsFound {
                        ContentUnavailableView("No results for \(searchText)", systemImage: "magnifyingglass", description: Text("Check the spelling or try a new search"))
                    } else {
                        LazyVGrid(columns: columns) {
                            if filteredCharacters.isEmpty {
                                ForEach(charactersVm.characters) { character in
                                    NavigationLink {
                                        CharacterDetails(characterID: character.id, characterName: character.name)
                                    } label: {
                                        Character(url: character.image, name: character.name, status: character.status)
                                    }
                                    .tint(.primary)
                                    .id(character.id)
                                }
                            }else {
                                ForEach(filteredCharacters) { character in
                                    NavigationLink {
                                        CharacterDetails(characterID: character.id, characterName: character.name)
                                    } label: {
                                        Character(url: character.image, name: character.name, status: character.status)
                                    }
                                    .tint(.primary)
                                    .id(character.id)
                                }
                            }
                        }
                        .padding(.horizontal, 5)
                        .navigationTitle("Rick and Morty")
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                
                                Menu("Sort by", systemImage: "line.3.horizontal.decrease.circle") {
                                    ForEach(Filters.allCases, id: \.self) { filter in
                                        Button {
                                            selectedFilter = filter
                                            filteredCharacters = charactersVm.filteredCharacters(filter: filter)
                                        } label: {
                                            Text(filter.rawValue)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .searchable(text: $searchText)
                .onChange(of: searchText) { oldValue, newValue in
                    if !searchText.isEmpty {
                        if  oldValue != newValue {
                            filteredCharacters = charactersVm.searchFilter(searchText: newValue)
                            noResultsFound = filteredCharacters.isEmpty
                        }
                    } else {
                        filteredCharacters = []
                        noResultsFound = false
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
    
}

