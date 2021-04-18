//
//  ProviderData.swift
//  Ghibli_Films
//
//  Created by Elfa Andika on 13/04/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol ServiceManager1 {
    var observMoviesData: BehaviorRelay<[MoviesModel]> {get set}
    var observErrorStatus: BehaviorRelay<String> {get set}
    func getMoviesData()
}
