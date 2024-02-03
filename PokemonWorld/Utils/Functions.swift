//
//  Functions.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 03.02.2024.
//

import Foundation
import SwiftUI

func dPrint(_ obj: Any...) {
    #if DEBUG
    print(obj)
    #endif
}

//MARK: Load image from url
func loadImageFromURL(urlString: String, completion: @escaping (UIImage?) -> Void) {
    guard let url = URL(string: urlString) else {
        completion(nil)
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil else {
            completion(nil)
            return
        }
        
        let loadedImage = UIImage(data: data)
        completion(loadedImage)
    }.resume()
}
