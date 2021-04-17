//
//  DataManager.swift
//  Ghibli_Films
//
//  Created by Elfa Andika on 13/04/21.
//

import Foundation
import RxSwift
import RxCocoa


class ServiceManager: ProviderData {
    
    var observFilms = BehaviorRelay<[MoviesModel]>.init(value: [])
    
    var disposeBag = DisposeBag()
    var service: DataService
    var decode: DecodeData
    
    init(service: DataService, decode: DecodeData) {
        self.service = service
        self.decode = decode
    }
    
    func getFilms() {
        
        let moviesData = self.service.getData()
            .flatMap { (data) in
                return self.decode.decode(data: data)
            }
        
        moviesData
            .subscribe { (decodedData) in
                self.observFilms.accept(decodedData)
                
            } onFailure: { (error) in
                fatalError()
            }.disposed(by: disposeBag)
        
    }
    
}
