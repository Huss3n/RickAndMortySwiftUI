//
//  Fetcher.swift
//  RickAndMorty
//
//  Created by Muktar Hussein on 28/04/2024.
//

import Foundation
import Combine
import SwiftUI
// character apu - https://rickandmortyapi.com/api/character

class CharacterService: ObservableObject {
    // be responsible for character fetctes made
    @Published var characters: [Characters] = []
    @Published var returnedCharacter: Characters?
    @Published var isLoading: Bool = true
    @Published var isCharactersFetched: Bool = true
    @Published var episodes: [Episode] = []
    
    var cancellables = Set<AnyCancellable>()
    var characterSubscription: AnyCancellable?
    
    init() {
        getCharacters()
    }
    
    private func getCharacters() {
        guard let url1 = URL(string: "https://rickandmortyapi.com/api/character/?page=1") else { return }
        guard let url2 = URL(string: "https://rickandmortyapi.com/api/character/?page=2") else { return }
        guard let url3 = URL(string: "https://rickandmortyapi.com/api/character/?page=3") else { return }
        
        let publishers = [url1, url2, url3].map { url in
            URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .tryMap(downlaodData)
                .decode(type: CharacterResponse.self, decoder: JSONDecoder())
                .map { $0.results } // Extract character results
                .eraseToAnyPublisher()
        }
        
        Publishers.MergeMany(publishers)
            .collect()
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { [weak self] allCharacters in
                self?.characters = allCharacters.flatMap { $0 }
                self?.isCharactersFetched = false
            }
            .store(in: &cancellables)
    }
    
    func filteredCharacters(filter: Filters) -> [Characters] {
        switch filter {
        case .alive:
            return characters.filter { $0.status == .alive }
        case .dead:
            return characters.filter { $0.status == .dead }
        case .unknown:
            return characters.filter { $0.status == .unknown }
        case .all:
            return characters
        }
    }
    
    func searchFilter(searchText: String) -> [Characters] {
        let searchLowercase = searchText.lowercased()
        return characters.filter { $0.name.lowercased().contains(searchLowercase)}
    }
    
    
    
    func getSingleCharacter(characterID: Int) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/\(characterID)") else { return }
//        print(url)
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(downlaodData)
            .decode(type: Characters.self, decoder: JSONDecoder())
            .sink { completion in
                print("Completion from single character: \(completion)")
                
            } receiveValue: { [weak self] returnedCharacters in
                self?.returnedCharacter = returnedCharacters
                self?.isLoading = false
                Task { [weak self] in
                    do {
                        if let episodes = try await self?.getEpisodes(episodesArray: returnedCharacters.episode) {
                            DispatchQueue.main.async { [weak self] in
                                self?.episodes = episodes
                                self?.isCharactersFetched = false
                                //                                print(episodes)
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func getEpisodes(episodesArray: [String] ) async throws -> [Episode] {
        var episodes: [Episode] = []
        
        for episodeURLString in episodesArray {
            guard let url = URL(string: episodeURLString) else {
                throw URLError(.badURL)
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let episode = try JSONDecoder().decode(Episode.self, from: data)
            episodes.append(episode)
        }
        return episodes
    }
    
    
    func downlaodData(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
