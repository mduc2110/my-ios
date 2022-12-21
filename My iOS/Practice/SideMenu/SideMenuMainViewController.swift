//
//  SideMenuMainViewController.swift
//  My iOS
//
//  Created by duc.vu1 on 13/11/2022.
//

import UIKit

protocol BaseCellController: AnyObject {
    func cellForRowAt(indexPath: IndexPath)
}

protocol CellController: BaseCellController {
    associatedtype T
    var shape: T { get set }
    init(shape: T)
    func calculate() -> Float
//    func cellForRowAt(tableView: UITableView, indexPath: IndexPath)
}

class Cell1: CellController {
    var shape: String
    
    required init(shape: String) {
        self.shape = shape
    }
    
    typealias T = String
    
    func calculate() -> Float {
        return 1
    }
    
    func cellForRowAt(indexPath: IndexPath) {
        //
    }
    
    
}

class SideMenuMainViewController: UIViewController {
    
    private lazy var menuVC = SideMenuViewController()
    private lazy var homeVC = SideMenuHomeViewController()

    private var navigationVC: UINavigationController?
    
    var source: [BaseCellController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVCs()
        view.backgroundColor = .red
        
        navigationVC?.view.frame.origin.x = view.frame.origin.x// + 100
        
        source = [
            Cell1(shape: "")
        ]
        
        for s in source {
        }
    }
    
    
    func addChildVCs() {
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        
        let navVC = UINavigationController(rootViewController: homeVC)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray6
        
        navVC.navigationBar.standardAppearance = appearance
        navVC.navigationBar.scrollEdgeAppearance = navVC.navigationBar.standardAppearance
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        
        navigationVC = navVC
    }
    
    
    

}
