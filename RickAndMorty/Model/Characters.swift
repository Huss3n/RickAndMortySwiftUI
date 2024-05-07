//
//  Characters.swift
//  RickAndMorty
//
//  Created by Muktar Hussein on 02/11/2023.
//

import Foundation

struct CharacterResponse: Codable {
    let results: [Characters]
}


// MARK: - Result
struct Characters: Codable, Identifiable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    // safe unwrap url
    var urlString: URL {
        let url = URL(string: url)
        return url!
    }
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

enum Filters: String, Codable, CaseIterable {
    case all = "All"
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unkwown"
}


enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}
