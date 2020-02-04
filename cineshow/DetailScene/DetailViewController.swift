//
//  DetailViewController.swift
//  cineshow
//
//  Created by Fernando Duarte on 27/01/20.
//  Copyright © 2020 Fernando Duarte. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblYear: UILabel!
    @IBOutlet var lblType: UILabel!
    @IBOutlet var btnFavorite: UIButton!
    @IBOutlet var imgView: UIImageView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        self.setUI()
    }
    
    func setUI() {
        if(movie != nil) {
            lblTitle.text = "Title: \(movie!.title ?? "")"
            lblType.text = "Type: \(movie!.type ?? "")"
            lblYear.text = "First run: \(movie!.year ?? "")"
            imgView.sd_setImage(with: URL(string: movie!.poster ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        }
        
        self.title = "Details"
    }
    
    @IBAction func click() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MovieDB", in: context)
        let newMovie = NSManagedObject(entity: entity!, insertInto: context)
        newMovie.setValue(movie?.title, forKey: "title")
        newMovie.setValue(movie?.type, forKey: "type")
        newMovie.setValue(movie?.imdbID, forKey: "imdbID")
        newMovie.setValue(movie?.poster, forKey: "poster")
        newMovie.setValue(movie?.year, forKey: "year")        
        do {
           try context.save()
          } catch {
           print("Failed saving")
        }
    }
}
