//
//  ProviderData.swift
//  Ghibli_Films
//
//  Created by Elfa Andika on 13/04/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProviderData {
    var observFilms: BehaviorRelay<[MoviesModel]> {get set}
    var errorStatus: BehaviorRelay<String> {get set}
    func getFilms()
}
