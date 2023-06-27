//
//  GetAllEpisodesResponse.swift
//  RickAndMorty
//
//  Created by Carlos De diego on 15/6/23.
//

import Foundation

struct GetAllEpisodesResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let info: Info
    let results: [Episode]
}
