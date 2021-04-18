//
//  APIService.swift
//  Ghibli_Films
//
//  Created by Elfa Andika on 13/04/21.
//

import UIKit
import RxSwift

final class APIService: DataService {
    
    func startService(url: URL) -> Single<Data> {
        
        return Single<Data>.create { single in
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
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
            return Disposables.create()
        }
    }
    
}
