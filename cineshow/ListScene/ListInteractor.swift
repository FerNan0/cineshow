//
//  ListInteractor.swift
//  cineshow
//
//  Created by Fernando Duarte on 27/01/20.
//  Copyright © 2020 Fernando Duarte. All rights reserved.
//

import Foundation
import CoreData

protocol ListFavoritesProtocol {
    func loadFavorites()
}

class ListInteractor: NSObject {
    var presenter: ListPresenter!
    
    func callEndPoint(argument: String) {
        let connector = Connector()
        connector.delegate = self
        let endpoint = "http://www.omdbapi.com/?s=\(argument)&apikey=2f406f7f"
        connector.getDataFrom(endpoint)
    }
    
    func loadFavorites(appDelegate: AppDelegate) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieDB")
        let context = appDelegate.persistentContainer.viewContext
        request.returnsObjectsAsFaults = false
        var movies = [Movie]()
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                var movieHelper = Movie()
                movieHelper.title = data.value(forKey: "title") as? String
                movieHelper.type = data.value(forKey: "type") as? String
                movieHelper.imdbID = data.value(forKey: "imdbID") as? String
                movieHelper.poster = data.value(forKey: "poster") as? String
                movieHelper.year = data.value(forKey: "year") as? String
                movies.append(movieHelper)
            }
            presenter.showData(movies: movies)
            
        } catch {
            
            print("Failed")
        }
        
    }
}

extension ListInteractor: CallbackResponse {    
    func response(fromConnector response: Data!) {
        print(response ?? "")
        if(response != nil) {
            do{
                let response = try JSONDecoder().decode(Response.self, from: response)
                self.presenter.showData(movies: response.search!)
            }catch {
                print(error)
            }
        }
    }
}
