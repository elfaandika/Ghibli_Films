//
//  MainCoordinator.swift
//  Ghibli_Films
//
//  Created by Elfa Andika on 15/04/21.
//

import Foundation
import UIKit
import RxSwift

class MainCoordinator: Coordinator {
    var navigatorController: UINavigationController?
    var childrenCoordinator = [Coordinator]()
    
    private let disposeBag = DisposeBag()
    private let presentableData: PresentableData
    
    init(data: PresentableData) {
        self.presentableData = data
    }
    
    func start() {
        var vc: UIViewController & Coordinating = MovieListViewController(movieViewMode: presentableData)
        vc.coordinator = self
        navigatorController?.setViewControllers([vc], animated: true)

    }
    
}
