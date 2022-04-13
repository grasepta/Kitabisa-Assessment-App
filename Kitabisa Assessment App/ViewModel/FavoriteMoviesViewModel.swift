//
//  FavoriteMoviesViewModel.swift
//  Kitabisa Assessment App
//
//  Created by Aldino Grasepta on 13/04/22.
//

import UIKit

class FavoriteMoviesViewModel {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favoriteMovies = [FavoriteMovie]()
    
    func getAllItems( completion : @escaping () -> ()) {
        do {
            favoriteMovies = try context.fetch(FavoriteMovie.fetchRequest())
            DispatchQueue.main.async {
                completion()
            }
        }
        catch { 
            //error
        }
    }
    
    func createItem(movieId: Int32) { 
        let newItem = FavoriteMovie(context: context)
        newItem.movieId = movieId
        
        do {
            try context.save()
        }
        catch {
        }
    }
    
    func deleteItem(item: FavoriteMovie) {
        context.delete(item)
        
        do {
            try context.save()
        }
        catch {
        }
    }
}
