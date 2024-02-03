//
//  ImageCache.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 03.02.2024.
//

import Foundation
import SwiftUI

class ImageCache {
    static let shared = ImageCache()

    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
