//
//  MovieListViewModel.swift
//  Ghibli_Films
//
//  Created by Elfa Andika on 13/04/21.
//

import Foundation
import RxSwift
import RxCocoa

final class PresentableMoviesData: PresentableData {
    var provider: ProviderData
    private let disposeBag = DisposeBag()
    
    var observResultMovies = BehaviorRelay<[MoviesModel]>.init(value: [])
    
    
    required init(provider: ProviderData) {
        self.provider = provider
    }
}

extension PresentableMoviesData {
    func moviesData(filter: String) {
        
        let withoutfilter = provider.observMoviesData
        let withfilter = provider.observMoviesData
            .map { $0.filter{$0.release_date.hasPrefix(filter)}}

        switch filter == "None" {
        case false:
            withfilter
                .subscribe { (movies) in
                    self.observResultMovies.accept(movies)}.disposed(by: disposeBag)
        default:
            withoutfilter
                    .subscribe { (movies) in
                        self.observResultMovies.accept(movies)}.disposed(by: disposeBag)
        }
        
    }
    
}

extension PresentableMoviesData {
    func yearData() -> Observable<[String]> {
        return Observable<[String]>.create { (observer) -> Disposable in
            
            self.provider.observMoviesData
                .subscribe { (movies) in
                    
                    var temp: [String] = ["None"]
                    for movie in movies {
                        if !temp.contains(movie.release_date) {
                            temp.append(movie.release_date)
                        }
                    }
                    observer.on(.next(temp))
                    observer.on(.completed)
                    
                } onError: { (error) in
                    observer.on(.error(error))
                    observer.on(.completed)
                    
                }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
        
    }
    
}
