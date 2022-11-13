//
//  Coordinator.swift
//  My iOS
//
//  Created by duc.vu1 on 31/10/2022.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}


class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = UIViewController()
        vc.view.backgroundColor = .yellow
        
        navigationController.pushViewController(vc, animated: true)
    }
    
}
