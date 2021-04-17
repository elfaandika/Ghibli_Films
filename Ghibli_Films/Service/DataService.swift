//
//  DataServiceProtocol.swift
//  Ghibli_Films
//
//  Created by Elfa Andika on 13/04/21.
//

import Foundation
import RxSwift

protocol DataService {
    func getData() -> Single<Data>
}
