//
//  SettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Carlos De diego on 15/6/23.
//

import UIKit

struct SettingsCellViewModel: Identifiable {
    let id = UUID()

    public let type: SettingsOption
    public let onTapHandler: (SettingsOption) -> Void

    // MARK: - Init

    init(type: SettingsOption, onTapHandler: @escaping (SettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }

    // MARK: - Public

    public var image: UIImage? {
        return type.iconImage
    }

    public var title: String {
        return type.displayTitle
    }

    public var iconContainerColor: UIColor {
        return type.iconContainerColor
    }
}
