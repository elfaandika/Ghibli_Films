//
//  PresentableData.swift
//  Ghibli_Films
//
//  Created by Elfa Andika on 13/04/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol PresentableData: GetMovieList, GetReleaseYear {
    var provider: ProviderData {get set}
    var observResultMovies: BehaviorRelay<[MoviesModel]> {get set}
    
    init(provider: ProviderData)
}
