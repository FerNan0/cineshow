//
//  ListCell.swift
//  cineshow
//
//  Created by Fernando Duarte on 03/02/20.
//  Copyright © 2020 Fernando Duarte. All rights reserved.
//

import UIKit
import SDWebImage

class ListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView! {
        didSet {            
        }
    }
    @IBOutlet weak var lblName: UILabel! {
       didSet {
           
       }
    }
    @IBOutlet weak var lblYear: UILabel! {
       didSet {
           
       }
    }
    
    func configure(image: String, name: String, year: String) {
        lblName.text = "Title: \(name)"
        lblYear.text = "First Run: \(year)"
        imgView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "placeholder.png"))
    }
}
