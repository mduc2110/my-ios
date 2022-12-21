//
//  ViewController.swift
//  My iOS
//
//  Created by duc.vu1 on 21/10/2022.
//

import UIKit
import FrameLayoutKit
//
//class ViewController: UIViewController {
//
//    private let contentLayout = VStackLayout()
//    private lazy var tableView: UITableView = {
////        let tableView = UITableView(frame: .zero, style: .grouped)
//        let tableView = UITableView(frame: .zero, style: .plain)
//        tableView.backgroundColor = .black
//
//        tableView.contentInset = UIEdgeInsets(top: -22, left: 0, bottom: 0, right: 0)
//
////        tableView.sectionHeaderHeight = .leastNormalMagnitude
////        tableView.sectionFooterHeight = .leastNormalMagnitude
////        // Remove header and footer spacing of the grouped table view
////        let leastMagnitudeView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
////        tableView.tableHeaderView = leastMagnitudeView
////        tableView.tableFooterView = leastMagnitudeView
//
//        tableView.delegate = self
//        tableView.dataSource = self
////        tableView.estimatedSectionHeaderHeight = .leastNormalMagnitude
////        tableView.contentInsetAdjustmentBehavior = .never
////        tableView.automaticallyAdjustsScrollIndicatorInsets = false
////        tableView.tableHeaderView = nil
////        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
//        return tableView
//    }()
//
//    private lazy var vieww: UIView = {
//        let view = UIView()
//        view.backgroundColor = .red
//        return view
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        setupUI()
//
//        tableView.reloadData()
//    }
//
//    private func setupUI() {
//        contentLayout.with {
//            ($0 + vieww).fixedHeight = 100
//            $0 + tableView
//        }
////        view.addSubview(contentLayout)
//        view.addSubview(vieww)
//        view.addSubview(tableView)
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        let viewSize = view.bounds
//        contentLayout.frame = viewSize
////        contentLayout.frame = CGRect(x: viewSize.minX, y: viewSize.minY + extendSafeAreaInsets.top, width: viewSize.width, height: viewSize.height)
////        tableView.frame = view.bounds
////
////        vieww.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//    }
//
//    private func openView() {
//        let navigation = UINavigationController(rootViewController: self)
//        let coordinator = MainCoordinator(navigationController: navigation)
//
//        coordinator.start()
////        let vc = UIViewController()
////        vc.view.backgroundColor = .blue
//////        vc.modalPresentationStyle = .fullScreen
////        present(vc, animated: true)
//
//    }
//}
//
//extension ViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 100
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        cell.textLabel?.text = "Row"
//        cell.accessoryType = .checkmark
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        print("🥲 \(indexPath.row)")
//        let contextItem = UIContextualAction(style: .normal, title: "Leading & .normal") { (contextualAction, view, boolValue) in
//            boolValue(true) // pass true if you want the handler to allow the action
//            print("Leading Action style .normal")
//        }
//        let contextItem2 = UIContextualAction(style: .destructive, title: "Leading & .destructive") { (contextualAction, view, boolValue) in
//            boolValue(true) // pass true if you want the handler to allow the action
//            print("Leading Action style .destructive")
//        }
//        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem, contextItem2])
//
//        return swipeActions
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UILabel()
//        view.text = "Header"
//        view.backgroundColor = UIColor(red: 200, green: 200, blue: 200, alpha: 1)
//        return view
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 100
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        openView()
//    }
//
//}
//
//extension ViewController: UITableViewDelegate {
//
//}


class ViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Click me", for: .normal)
        button.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
        button.backgroundColor = .systemRed
        if #available(iOS 15, *) {
            UIButton.Configuration.filled()
        }
        
        return button
    }()
    
    private lazy var btn2: UIButton = {
        let button = UIButton()
        button.setTitle("My buttn", for: .normal)
//        button.setTitleColor(UIColor.systemBlue, for: .normal)
        
        if #available(iOS 15, *) {
            var config = UIButton.Configuration.filled()
            config.buttonSize = .large
            config.cornerStyle = .small
            
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont.preferredFont(forTextStyle: .headline)

                return outgoing
            }
            config.imagePlacement = .trailing
            
            button.configuration = config
        }

        return button
    }()
    
    private lazy var drawView: DrawView = {
        let draw = DrawView()
        draw.backgroundColor = .white
        draw.layer.borderWidth = 1
        draw.layer.borderColor = UIColor.brown.cgColor
        return draw
    }()
    
    private lazy var uiView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    
    private lazy var uiView2: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(button)
//        view.addSubview(uiView)
//        view.addSubview(uiView2)
        view.addSubview(btn2)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        drawView.frame = CGRect(x: view.center.x - 150, y: view.center.y - 150, width: 300, height: 300)
        
        uiView.frame = CGRect(x: view.center.x - 80, y: view.center.y - 80, width: 160, height: 160)//.inset(by: UIEdgeInsets(top: 15, left: 20, bottom: 25, right: 30))
        uiView2.frame = CGRect(x: view.center.x - 75, y: view.center.y - 75, width: 150, height: 150)
        
        uiView.frame = uiView.frame.inset(by: UIEdgeInsets(top: 15, left: 20, bottom: 25, right: 30))
        
        let btn2Size = btn2.sizeThatFits(view.bounds.size)
        btn2.frame = CGRect(x: view.center.x - btn2Size.width / 2, y: view.center.y - btn2Size.height / 2, width: btn2Size.width, height: btn2Size.height)

    }

    @objc private func tapOnButton() {
//        let currentVC = KeyboardViewController()
//        currentVC.modalPresentationStyle = .fullScreen
//
//        present(currentVC, animated: true)
        
        let currentVC = SideMenuMainViewController()
        presentFullScreen(currentVC, animated: true)
    }

}


extension UIViewController {
    func presentFullScreen(_ viewController: UIViewController, animated: Bool) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated)
    }
}
