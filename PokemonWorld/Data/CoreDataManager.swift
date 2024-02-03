//
//  DataController.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 25.01.2024.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {

    static let shared = CoreDataManager()
    
    let container = NSPersistentContainer(name: "PokemonWorldCoreData")
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    private init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                dPrint("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        do {
            try viewContext.save()
            dPrint("Data saved")
        } catch {
            viewContext.rollback()
            dPrint("Failed to save the data \(error.localizedDescription)")
        }
    }
    
    func deletePokemon(_ pokemonSaved: PokemonSaved) {
        viewContext.delete(pokemonSaved)
        save()
    }
    
    func getPokemonById(id: NSManagedObjectID) -> PokemonSaved? {
        do {
            return try viewContext.existingObject(with: id) as? PokemonSaved
        } catch {
            dPrint("Failed to get object by id")
            return nil
        }
    }
    
    func getSavedPokemons() -> [PokemonSaved] {
        let request: NSFetchRequest<PokemonSaved> = PokemonSaved.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            dPrint("Failed to load the data")
            return []
        }
    }
}
