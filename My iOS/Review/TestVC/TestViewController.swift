//
//  TestViewController.swift
//  My iOS
//
//  Created by duc.vu1 on 08/11/2022.
//

import UIKit
import FrameLayoutKit

class TestViewController: UIViewController {
    
    private let contentLayout = VStackLayout()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
//        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .black
        
//        tableView.contentInset = UIEdgeInsets(top: -22, left: 0, bottom: 0, right: 0)
        
        //        tableView.sectionHeaderHeight = .leastNormalMagnitude
        //        tableView.sectionFooterHeight = .leastNormalMagnitude
        //        // Remove header and footer spacing of the grouped table view
        //        let leastMagnitudeView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        //        tableView.tableHeaderView = leastMagnitudeView
        //        tableView.tableFooterView = leastMagnitudeView
//        extendedLayoutIncludesOpaqueBars
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.inputViewController?.edgesForExtendedLayout
        //        tableView.estimatedSectionHeaderHeight = .leastNormalMagnitude
        //        tableView.contentInsetAdjustmentBehavior = .never
        //        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        //        tableView.tableHeaderView = nil
        //        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        return tableView
    }()
    
    private lazy var vieww: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        
        tableView.reloadData()
    }
    
    private func setupUI() {
        contentLayout.with {
            ($0 + vieww).fixedHeight = 100
            $0 + tableView
        }
        //        view.addSubview(contentLayout)
        view.addSubview(vieww)
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let viewSize = view.bounds
        contentLayout.frame = viewSize
        //        contentLayout.frame = CGRect(x: viewSize.minX, y: viewSize.minY + extendSafeAreaInsets.top, width: viewSize.width, height: viewSize.height)
        //        tableView.frame = view.bounds
        //
        //        vieww.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
    
    private func openView() {
        let navigation = UINavigationController(rootViewController: self)
        let coordinator = MainCoordinator(navigationController: navigation)
        
        coordinator.start()
        //        let vc = UIViewController()
        //        vc.view.backgroundColor = .blue
        ////        vc.modalPresentationStyle = .fullScreen
        //        present(vc, animated: true)
        
    }
}

extension TestViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Row"
        cell.accessoryType = .checkmark
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print("🥲 \(indexPath.row)")
        let contextItem = UIContextualAction(style: .normal, title: "Leading & .normal") { (contextualAction, view, boolValue) in
            boolValue(true) // pass true if you want the handler to allow the action
            print("Leading Action style .normal")
        }
        let contextItem2 = UIContextualAction(style: .destructive, title: "Leading & .destructive") { (contextualAction, view, boolValue) in
            boolValue(true) // pass true if you want the handler to allow the action
            print("Leading Action style .destructive")
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem, contextItem2])
        
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel()
        view.text = "Header"
        view.backgroundColor = .cyan
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        openView()
    }
    
}

extension TestViewController: UITableViewDelegate {
    
}

extension UIDevice {
    static func isPhone() -> Bool {
        return current.userInterfaceIdiom == .phone
    }
    
    static func isIPhoneXType() -> Bool {
        return self.isPhone() && (UIScreen.main.nativeBounds.height >= 2436 || UIScreen.main.nativeBounds.height >= 1792 || UIScreen.main.nativeBounds.height >= 2688)
    }
}

fileprivate var extendSafeAreaInsets: UIEdgeInsets = .zero

extension UIView {
    
    var extendSafeEdgeInsets: UIEdgeInsets {
        if extendSafeAreaInsets == .zero {
            if #available(iOS 11.0, *), UIDevice.isIPhoneXType() {
                var safeAreaInsets: UIEdgeInsets? = .zero
                if #available(iOS 13.0, *) {
                    safeAreaInsets = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.safeAreaInsets
                }
                else {
                    safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets
                }
                if safeAreaInsets == nil {
                    safeAreaInsets = UIWindow().safeAreaInsets
                }
                if UIDevice.isIPhoneXType() {
                    extendSafeAreaInsets = UIEdgeInsets(top: max(safeAreaInsets!.top - 15.0, 0.0), left: safeAreaInsets!.left, bottom: safeAreaInsets!.bottom, right: safeAreaInsets!.right)
                } else {
                    extendSafeAreaInsets = UIEdgeInsets(top: max(safeAreaInsets!.top - 20.0, 0.0), left: safeAreaInsets!.left, bottom: safeAreaInsets!.bottom, right: safeAreaInsets!.right)
                }
                
            }
        }
        return extendSafeAreaInsets
    }
}
