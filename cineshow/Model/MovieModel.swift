//
//  MovieModel.swift
//  cineshow
//
//  Created by Fernando Duarte on 03/02/20.
//  Copyright © 2020 Fernando Duarte. All rights reserved.
//

import Foundation

struct Response: Codable {
    var response: String?
    var totalResults: String?
    var search: [Movie]?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingResponseKeys.self)
        totalResults = try values.decode(String.self, forKey: .totalResults)
        response = try values.decode(String.self, forKey: .Response)
        search = try values.decode([Movie].self, forKey: .Search)
    }
    enum CodingResponseKeys: String, CodingKey {
        case Response
        case totalResults
        case Search
    }
}

struct Movie: Codable {
    var year: String?
    var type: String?
    var title: String?
    var imdbID: String?
    var poster: String?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingMovieKeys.self)
        year = try values.decode(String.self, forKey: .Year)
        type = try values.decode(String.self, forKey: .Type)
        title = try values.decode(String.self, forKey: .Title)
        imdbID = try values.decode(String.self, forKey: .imdbID)
        imdbID = try values.decode(String.self, forKey: .Poster)
    }
    
    enum CodingMovieKeys: String, CodingKey {
        case Year
        case `Type`
        case Title
        case imdbID
        case Poster
    }

}
