//
//  DecodeHTTP.swift
//  Ghibli_Films
//
//  Created by Elfa Andika on 13/04/21.
//

import Foundation
import RxSwift

final class DecodeMoviesModel: DecodeData {
    func decode(data: Data) -> Single<[MoviesModel]> {
        return Single<[MoviesModel]>.create { observer in
            do {
                let result = try JSONDecoder().decode([MoviesModel].self, from: data)
                observer(.success(result))
            }
            
            catch {
                observer(.failure(error))
            }
            return Disposables.create()
        }
    }
    
    
}
