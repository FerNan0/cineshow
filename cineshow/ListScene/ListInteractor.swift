//
//  ListInteractor.swift
//  cineshow
//
//  Created by Fernando Duarte on 27/01/20.
//  Copyright © 2020 Fernando Duarte. All rights reserved.
//
//http://www.omdbapi.com/?s=Bat&apikey=2f406f7f
import Foundation

class ListInteractor: NSObject {
    var presenter: ListPresenter!
    
    func callEndPoint(argument: String) {
        let connector = Connector()
        connector.delegate = self
        let endpoint = "http://www.omdbapi.com/?s=\(argument)&apikey=2f406f7f"
        connector.getDataFrom(endpoint)
    }
}

extension ListInteractor: CallbackResponse {
    func response(fromConnector response: String!) {
        
    }
}
