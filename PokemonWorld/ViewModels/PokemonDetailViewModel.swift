//
//  PokemonDetailViewModel.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 25.01.2024.
//

import SwiftUI
import CoreData

class PokemonDetailViewModel: ObservableObject {
    private let pokemonRepository: PokemonRepository = PokemonRepository()
    
    @MainActor @Published var currentPokemonDetail: PokemonDetail?
    
    @MainActor @Published var image: UIImage?
    
    //MARK: Find detail by pokemon
    @MainActor func getDetailByPokemon(stringUrl: String?) {
        guard let url = stringUrl else {
            return
        }
        
        //MARK: Request if not saved
        Task {
            do {
                let listOfSavedPokemons = CoreDataManager.shared.getSavedPokemons()
                
                //MARK: Check on saved pokemon
                let savedPokemon = listOfSavedPokemons.first { pokemon in
                    pokemon.key == url
                }
                
                if savedPokemon != nil {
                    //MARK: Take from database
                    print("IMAGE FROM DB: \(String(describing: savedPokemon?.image))")
                    
                    await MainActor.run {
                        image = UIImage(data: savedPokemon?.image ?? Data())
                        currentPokemonDetail = PokemonDetail.fromJSON(json: savedPokemon?.jsonPokemon ?? "")
                    }
                    
                    print("Take data from DB")
                } else {
                    //MARK: Take from server
                    //Get response more pokemon
                    let pokemonDetail = try await pokemonRepository.getPokemonDetail(stringUrl: url)
                    
                    //Load image
                    loadImageFromURL(urlString: pokemonDetail.imageUrl ?? "") { imageFromData in
                        self.image = imageFromData
                        
                        self.saveNewPokemon(key: url, jsonPokemon: pokemonDetail.toJSON(), image: self.image?.pngData())
                    }
                    
                    //Set pokemon detail
                    await MainActor.run {
                        currentPokemonDetail = pokemonDetail
                    }
                    
                    print("Take data from server")
                }
                
            } catch {
                print("Fetching establishments failed with error \(error)")
            }
        }
        
    }
    
    private func saveNewPokemon(key: String, jsonPokemon: String, image: Data?) {
        let pokemonSaved = PokemonSaved(context: CoreDataManager.shared.viewContext)
        
        pokemonSaved.key = key
        pokemonSaved.jsonPokemon = jsonPokemon
        pokemonSaved.image = image
        
        CoreDataManager.shared.save()
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
}