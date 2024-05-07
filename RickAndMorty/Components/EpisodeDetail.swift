//
//  EpisodeDetail.swift
//  RickAndMorty
//
//  Created by Muktar Hussein on 06/05/2024.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine


class EpisodeDetailVM: ObservableObject {
    @Published var fetchedCharacters: [Characters] = []
    @Published var isDataNotFetched: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    
    init() {
    }
    
    func fetchCharacters(fromURL url: String) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(downlaodData)
            .decode(type: Characters.self, decoder: JSONDecoder())
            .sink { completion in
                print("Completion from Episode detail vm \(completion)")
            } receiveValue: {[weak self] returnedCharacters in
                self?.fetchedCharacters.append(returnedCharacters)
            }
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

struct EpisodeDetail: View {
    @StateObject private var vm = EpisodeDetailVM()
    @State private var charactersFromArray: [Characters] = []
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    
    var episodeName: String = "ABC's"
    var airDate: String = "12-12"
    var episode: String = "S3E09"
    var created: String = "!2-12"
    
    var characters: [String] =
    ["https://rickandmortyapi.com/api/episode/1",
     "https://rickandmortyapi.com/api/episode/2",
     "https://rickandmortyapi.com/api/episode/3",
     "https://rickandmortyapi.com/api/episode/4",
     "https://rickandmortyapi.com/api/episode/5"
    ] // <- has an array of urls which are strings
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    top
                    Text("Characters")
                        .font(.title.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    LazyVGrid(columns: columns) {
                        ForEach(vm.fetchedCharacters) { fetchedChar in
                            NavigationLink {
                                CharacterDetails(characterID: fetchedChar.id, characterName: fetchedChar.name)
                            } label: {
                                Character(
                                url: fetchedChar.image,
                                name: fetchedChar.name,
                                status: fetchedChar.status
                                )
                                .padding(.horizontal, 2)
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                }
                .navigationTitle(episodeName)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {}, label: {
                            Image(systemName: "square.and.arrow.up")
                                .fontWeight(.bold)
                                .imageScale(.large)
                        })
                    }
                }
                .onAppear {
                    fetchDataForCharacters() // Call this function onAppear
                }
            }
        }
    }
    
    private func fetchDataForCharacters() {
        // Use a set to store unique URLs and avoid duplicates
        var uniqueCharacterUrls = Set<String>()
        for characterURL in characters {
            if !uniqueCharacterUrls.contains(characterURL) {
                uniqueCharacterUrls.insert(characterURL)
//                print("Fetching character data for URL: \(characterURL)")
                vm.fetchCharacters(fromURL: characterURL)
            }
        }
    }
    
}

#Preview {
    EpisodeDetail()
}

extension EpisodeDetail {
    private func episodeMoment(firstText: String, secondText: String) -> some View {
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
    
    
    private var top: some View {
        Group {
            episodeMoment(firstText: "Episode Name", secondText: episodeName)
            episodeMoment(firstText: "Air date", secondText: airDate)
            episodeMoment(firstText: "Episode", secondText: episode)
            episodeMoment(firstText: "Created", secondText: created)
        }
    }
}
