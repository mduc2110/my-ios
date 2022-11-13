//
//  KeyboardViewController.swift
//  My iOS
//
//  Created by duc.vu1 on 08/11/2022.
//

import Foundation
import UIKit


class CommonInputField: UITextField {
    private let edgeInsets: UIEdgeInsets
    
    init(edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        self.edgeInsets = edgeInsets
        super.init(frame: .zero)
        
        self.addTarget(self, action: #selector(tapOnInputField), for: .touchDown)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: edgeInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: edgeInsets)
    }
    
    @objc private func tapOnInputField() {
        self.layer.sublayers?[0].backgroundColor = UIColor.systemGreen.cgColor
    }

}


class KeyboardViewController: UIViewController {
    
//    private lazy var inputField: UITextField = {
//        let inputField = UITextField()
//        inputField.backgroundColor = .red.withAlphaComponent(0.1)
//        inputField.keyboardAppearance = .light
//        return inputField
//    }()
    
    private lazy var inputField: CommonInputField = {
        let input = CommonInputField(edgeInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        input.layer.cornerRadius = 3
        input.placeholder = "Họ và tên"
        return input
    }()
    
    private lazy var inputField2: UITextField = {
        let inputField = UITextField()
        inputField.keyboardAppearance = .dark
        inputField.layer.borderColor = UIColor.lightGray.cgColor
        inputField.layer.borderWidth = 1
        inputField.layer.cornerRadius = 3
        return inputField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .cyan
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("Motion")
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        print("pressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        inputField.becomeFirstResponder()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardHideShow), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func onKeyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField
        else { return }
//            let keyboardHeight = keyboardFrame.cgRectValue.height
//            let bottomSpace = self.view.frame.height - button.frame.maxY
//            if keyboardHeight > bottomSpace {
//                self.view.frame.origin.y -= keyboardHeight - bottomSpace + 20
//            }
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, to: currentTextField.superview)
        
        let textFieldBottomY = convertedTextFieldFrame.maxY
        
        if textFieldBottomY + 20 > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2)
            view.frame.origin.y -= newFrameY
        }
    }
    
    @objc private func onKeyboardHideShow(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(inputField)
        view.addSubview(inputField2)
        view.addSubview(button)

        inputField2.frame = CGRect(x: view.center.x - 75, y: 100, width: 150, height: 50)
        
        let inputFieldSize = inputField.sizeThatFits(view.bounds.size)
        inputField.frame = CGRect(x: view.center.x - 75, y: view.center.y + 75, width: 150, height: inputFieldSize.height)
        inputField.border(for: .right, color: .lightGray , width: 1)
        
        let inputFieldFrame = inputField.frame
        button.frame = CGRect(x: view.center.x - 75, y: inputFieldFrame.maxY + 30, width: 150, height: 50)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }
    
}


extension UIResponder {
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    ///Find the current firest responder
    /// - Returns: the current UIResponder if it exists
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
        
    @objc private func _trap() { Static.responder = self }
    
}

extension UIView {
    func drawLine(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
//        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(20)
        
//        context.addLines(between: [
//            CGPoint(x: 5, y: 0),
////            CGPoint(x: 0, y: 0),
//            CGPoint(x: 0, y: 100)//,
////            CGPoint(x: 60, y: 40),
////            CGPoint(x: 60, y: 100),
////            CGPoint(x: 0, y: 100)
//        ])
//        context.move(to: CGPoint(x: 59, y: 14))
        
        let rect = CGRect(x: 0, y: 0, width: 300, height: 300).insetBy(dx: 10, dy: 10)
        context.setFillColor(UIColor.systemRed.cgColor)
        context.setStrokeColor(UIColor.systemGreen.cgColor)
        context.addRect(rect)
        context.drawPath(using: .fillStroke)
        context.fill(rect)
        
        context.strokePath()
    }
    
    func addBorder() {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.cyan.cgColor)
        context.setLineWidth(10.0)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 10, y: 10))
        path.addRect(CGRect(x: 10, y: 10, width: 50, height: 50))
    
        
        context.addPath(path)
        
        
        context.strokePath()
    }
    
    func createSquare(color: UIColor, width: CGFloat) {
        let shapeLayer = CAShapeLayer()
        
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0.0, y: 40.0))
//        path.addLine(to: CGPoint(x: 100.0, y: 40.0))
//        //        path.close() // creating a line segment between the first point and current point
//
//        shapeLayer.path = path.cgPath
//        shapeLayer.strokeColor = UIColor.red.cgColor
        
        let border = CALayer()
        border.backgroundColor = UIColor.red.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1)
        layer.addSublayer(border)
    }
    
    func border(for position: BorderPosition, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        switch position {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: width)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        case .right:
            border.frame = CGRect(x: self.frame.size.width, y: 0, width: width, height: self.frame.size.height)
        case .all:
            break
        }
        layer.addSublayer(border)
    }
    
    func borderAll(color: UIColor, width: CGFloat) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    enum BorderPosition {
        case top, bottom, left, right, all
    }
}

class DrawView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawLine(rect)
    }
}
