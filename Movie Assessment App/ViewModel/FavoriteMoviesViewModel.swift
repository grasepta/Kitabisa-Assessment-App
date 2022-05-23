//
//  FavoriteMoviesViewModel.swift
//  Kitabisa Assessment App
//
//  Created by Aldino Grasepta on 13/04/22.
//

import UIKit
import CoreData

class FavoriteMoviesViewModel {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favoriteMovies = [FavoriteMovie]()
    
    func getAllItems( completion : @escaping () -> ()) {
        do {
            favoriteMovies = try context.fetch(FavoriteMovie.fetchRequest())
            DispatchQueue.main.async {
                completion()
            }
        } catch {
            //error
        }
    }
    
    func createItem(movieId: Int32) { 
        let newItem = FavoriteMovie(context: context)
        newItem.movieId = movieId
        
        do {
            try context.save()
        } catch {
        }
    }
    
    func deleteItem(movieId: Int32) {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "movieId==\(movieId)")
        let objects = try! context.fetch(fetchRequest)
        for obj in objects {
            context.delete(obj)
        }

        do {
            try context.save()
            
        } catch {
            //error
        }
    }
    
    func checkIfItemExist(id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteMovie")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "movieId == %d" ,id)

        do {
            let count = try context.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func toggleFavorite(_ movieId:Int) {
        if checkIfItemExist(id: movieId) {
            deleteItem(movieId: Int32(movieId))
        } else {
            createItem(movieId: Int32(movieId))
        }
    }
}
