//
//  Location.swift
//  RickAndMorty
//
//  Created by Muktar Hussein on 06/05/2024.
//

import Foundation


struct LocationModel: Codable, Identifiable  {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
