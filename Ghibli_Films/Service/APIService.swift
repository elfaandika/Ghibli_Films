//
//  APIService.swift
//  Ghibli_Films
//
//  Created by Elfa Andika on 13/04/21.
//

import UIKit
import RxSwift

class APIService: DataService {
    
    func getData() -> Single<Data> {
        
        return Single<Data>.create { single in
            let task = URLSession.shared.dataTask(with: URL(string: "https://ghibliapi.herokuapp.com/films")!) { (data, response, error) in
                if let error = error {
                    single(.failure(error))
                    return
                }
                
                guard let data = data else {
                    single(.failure(error!))
                    return
                }
                single(.success(data))
            }
            task.resume()
            return Disposables.create{task.cancel()}
        }
    }
    
}
