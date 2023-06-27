//
//  CharacterStatus.swift
//  RickAndMorty
//
//  Created by Carlos De diego on 15/6/23.
//

import Foundation

enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"

    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
