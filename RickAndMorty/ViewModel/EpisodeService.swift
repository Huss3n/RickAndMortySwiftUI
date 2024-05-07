//
//  EpisodeService.swift
//  RickAndMorty
//
//  Created by Muktar Hussein on 06/05/2024.
//

import Foundation
import Combine

struct EpisodesResponse: Decodable {
    let results: [Episode]
}

class EpisodeService: ObservableObject {
    @Published var allEpisodes: [Episode] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getAllEpisodes()
    }
    
    private func getAllEpisodes()  {
        guard let url = URL(string: "https://rickandmortyapi.com/api/episode") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap (downlaodData)
            .decode(type: EpisodesResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] episodes in
                self?.allEpisodes = episodes.results
            })
            .store(in: &cancellables)
        
        
    }
    
    func downlaodData(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
