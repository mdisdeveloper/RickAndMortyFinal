//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by Carlos De diego on 15/6/23.
//

import Foundation

/// Represents unique API endpoint
@frozen enum Endpoint: String, CaseIterable, Hashable {
    /// Endpoint to get character info
    case character
    /// Endpoint to get location info
    case location
    /// Endpoint to get episode info
    case episode
}
