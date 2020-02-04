//
//  ListCell.swift
//  cineshow
//
//  Created by Fernando Duarte on 03/02/20.
//  Copyright © 2020 Fernando Duarte. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView! {
        didSet {
            self.imgView.backgroundColor = .red
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
    
    func configure(image: UIImage, name: String, year: String) {
        lblName.text = "Title: \(name)"
        lblYear.text = "First Run: \(year)"
    }
}
