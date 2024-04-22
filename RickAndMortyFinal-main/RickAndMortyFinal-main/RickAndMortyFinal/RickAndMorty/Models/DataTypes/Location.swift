//
//  Location.swift
//  RickAndMorty
//
//  Created by Carlos De diego on 15/6/23.
//

import Foundation

struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
