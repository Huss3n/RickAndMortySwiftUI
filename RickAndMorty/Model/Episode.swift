//
//  Episode.swift
//  RickAndMorty
//
//  Created by Muktar Hussein on 03/05/2024.
//

import Foundation

struct Episode: Codable, Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, url, created
        case airDate = "air_date"
    }
}

/*
 {
 "id": 6,
 "name": "Rick Potion #9",
 "air_date": "January 27, 2014",
 "episode": "S01E06",
 "characters": [
 "https://rickandmortyapi.com/api/character/1",
 "https://rickandmortyapi.com/api/character/2",
 "https://rickandmortyapi.com/api/character/3",
 "https://rickandmortyapi.com/api/character/4",
 "https://rickandmortyapi.com/api/character/5",
 "https://rickandmortyapi.com/api/character/38",
 "https://rickandmortyapi.com/api/character/58",
 "https://rickandmortyapi.com/api/character/82",
 "https://rickandmortyapi.com/api/character/83",
 "https://rickandmortyapi.com/api/character/92",
 "https://rickandmortyapi.com/api/character/155",
 "https://rickandmortyapi.com/api/character/175",
 "https://rickandmortyapi.com/api/character/179",
 "https://rickandmortyapi.com/api/character/181",
 "https://rickandmortyapi.com/api/character/216",
 "https://rickandmortyapi.com/api/character/234",
 "https://rickandmortyapi.com/api/character/239",
 "https://rickandmortyapi.com/api/character/249",
 "https://rickandmortyapi.com/api/character/251",
 "https://rickandmortyapi.com/api/character/271",
 "https://rickandmortyapi.com/api/character/293",
 "https://rickandmortyapi.com/api/character/338",
 "https://rickandmortyapi.com/api/character/343",
 "https://rickandmortyapi.com/api/character/394"
 ],
 "url": "https://rickandmortyapi.com/api/episode/6",
 "created": "2017-11-10T12:56:34.339Z"
 }
 */
