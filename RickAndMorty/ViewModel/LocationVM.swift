//
//  AppViewModel.swift
//  RickAndMorty
//
//  Created by Muktar Hussein on 20/11/2023.
//

import SwiftUI
import Combine

struct LocationResponse: Codable {
    let results: [LocationModel]
}

class LocationVM: ObservableObject {
    @Published var locations: [LocationModel] = []
    var cancellable = Set<AnyCancellable>()
    
    init() {
        getAllLocations()
    }
    
    private func getAllLocations() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/location") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(downlaodData)
            .decode(type: LocationResponse.self, decoder: JSONDecoder())
            .sink { completion in
                print("Completion from location \(completion)")
            } receiveValue: {[weak self] returnedLocations in
                guard let self = self else { return }
                self.locations = returnedLocations.results
            }
            .store(in: &cancellable)

    }
    
    
    func downlaodData(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
