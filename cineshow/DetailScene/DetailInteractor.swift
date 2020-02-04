//
//  DetailInteractor.swift
//  cineshow
//
//  Created by Fernando Duarte on 27/01/20.
//  Copyright © 2020 Fernando Duarte. All rights reserved.
//

import Foundation
import CoreData

class DetailInteractor: NSObject {
    var presenter: DetailPresenter!
    
    func saveFavorite(movie: Movie, appDelegate: AppDelegate) {        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MovieDB", in: context)
        let newMovie = NSManagedObject(entity: entity!, insertInto: context)
        newMovie.setValue(movie.title, forKey: "title")
        newMovie.setValue(movie.type, forKey: "type")
        newMovie.setValue(movie.imdbID, forKey: "imdbID")
        newMovie.setValue(movie.poster, forKey: "poster")
        newMovie.setValue(movie.year, forKey: "year")
        do {
           try context.save()
          } catch {
           print("Failed saving")
        }
    }
}
