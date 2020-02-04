//
//  DetailViewController.swift
//  cineshow
//
//  Created by Fernando Duarte on 27/01/20.
//  Copyright © 2020 Fernando Duarte. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblYear: UILabel!
    @IBOutlet var lblType: UILabel!
    @IBOutlet var btnFavorite: UIButton!
    @IBOutlet var imgView: UIImageView!
    
    var movie: Movie?
    var interactor: DetailInteractor!
    
    override func viewDidLoad() {
        interactor = DetailInteractor()
        let presenter = DetailPresenter()
        presenter.viewController = self
        interactor.presenter = presenter
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
        interactor.saveFavorite(movie: movie ?? Movie(), appDelegate: appDelegate)
    }
}
