//
//  CharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Afraz Siddiqui on 12/24/22.
//

import Foundation

final class CharacterPhotoCollectionViewCellViewModel {
    private let imageUrl: URL?

    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }

    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
}
