//
//  ghibliMoviesAPIConfig.swift
//  Ghibli_Films
//
//  Created by Elfa Andika on 17/04/21.
//

import Foundation

struct ghibliMoviesAPIConfig: APIConfig {
    var infoURL: URL = URL(string: "https://ghibliapi.herokuapp.com/films")!
    var apiKey: String = ""
    
}
