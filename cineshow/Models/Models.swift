//
//  Models.swift
//  cineshow
//
//  Created by Fernando Duarte on 28/01/20.
//  Copyright © 2020 Fernando Duarte. All rights reserved.
//

import Foundation

enum MovieKeys: String, CodingKey {
    case year
    case type
    case title
    case imdbID
    case poster
}

struct MovieModel: Codable {
    var year: Int?
    var type: String?
    var title: String?
    var imdbID: String?
    var poster: String?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: MovieKeys.self)
        year = try values.decode(Int.self, forKey: .year)
        type = try values.decode(String.self, forKey: .type)
        title = try values.decode(String.self, forKey: .title)
        imdbID = try values.decode(String.self, forKey: .imdbID)
        poster = try values.decode(String.self, forKey: .poster)
    }
}
