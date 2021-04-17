//
//  Coordinator.swift
//  Ghibli_Films
//
//  Created by Elfa Andika on 15/04/21.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigatorController: UINavigationController? {get set}
    var childrenCoordinator: [Coordinator] {get set}
    
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? {get set}
    
}
