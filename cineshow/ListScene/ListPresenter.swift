//
//  ListPresenter.swift
//  cineshow
//
//  Created by Fernando Duarte on 27/01/20.
//  Copyright © 2020 Fernando Duarte. All rights reserved.
//

import Foundation

protocol PresenterProtocol {
    func showData(movies:[Movie])
}

class ListPresenter: NSObject {
    var viewController: ListViewController!
}

extension ListPresenter: PresenterProtocol {
    func showData(movies: [Movie]) {
        viewController.showData(movies: movies)
    }
    
}
