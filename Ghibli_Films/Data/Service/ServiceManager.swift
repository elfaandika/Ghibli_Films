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
    
    var observErrorStatus = BehaviorRelay<String>.init(value: "")
    var observMoviesData = BehaviorRelay<[MoviesModel]>.init(value: [])
    
    private let disposeBag = DisposeBag()
    private let service: DataService
    private let decode: DecodeData
    private let config: APIConfig
    
    init(service: DataService, decode: DecodeData, config: APIConfig) {
        self.service = service
        self.decode = decode
        self.config = config
        
    }
    
    func getMoviesData() {
        
        let moviesData = self.service.startService(url: config.infoURL)
            .flatMap { (data) in
                return self.decode.decode(data: data)
            }
        
        moviesData
            .subscribe { (decodedData) in
                self.observMoviesData.accept(decodedData)
                
            } onFailure: { (error) in
                self.observErrorStatus.accept(error.localizedDescription)
                
            }.disposed(by: disposeBag)

    }
    
}
