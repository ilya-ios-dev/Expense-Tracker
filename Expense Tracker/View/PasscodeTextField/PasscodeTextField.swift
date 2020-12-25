//
//  CustomTextField.swift
//  Expense Tracker
//
//  Created by isEmpty on 23.12.2020.
//

import UIKit

@IBDesignable
final class PasscodeTextField: UIControl {
    
    //MARK: - Properties
    private(set) var text: String = "" // Returns the entered text.
    
    // Tags are used to communicate with PinView. nextTag is used as an iterator in `PinViews`.
    private var nextTag = 1 {
        didSet {
            if nextTag > oldValue {
                (pinsStack.arrangedSubviews as! [PINView]).first{ $0.isNext == false }?.isNext = true
            } else {
                (pinsStack.arrangedSubviews as! [PINView]).last{ $0.isNext == true }?.isNext = false
            }
        }
    }
    
    private lazy var pinsStack: UIStackView = {
        let sv = UIStackView.init()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fill
        sv.spacing = spacing
        return sv
    }()
    
    var keyboardType: UIKeyboardType = .numberPad
    var hasText: Bool {
        return nextTag > 1 ? true : false
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    //MARK: - IBInspectable Properties
    /// Number of digits in the pin code.
    @IBInspectable var numberOfDigits: Int = 4 {
        didSet{
            self.configureViews()
            self.setNeedsDisplay()
        }
    }
    /// `PINView` width
    @IBInspectable var pinViewWidth: CGFloat = 50{
        didSet{
            self.configureViews()
            self.setNeedsDisplay()
        }
    }
    /// `PINView` font size
    @IBInspectable var pinViewFontSize: CGFloat = 33 {
        didSet{
            self.configureViews()
            self.setNeedsDisplay()
        }
    }
    
    /// Distance between views.
    @IBInspectable var spacing: CGFloat = 12 {
        didSet{
            pinsStack.spacing = spacing
            self.configureViews()
            self.layoutIfNeeded()
        }
    }
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.becomeFirstResponder()
        addSubViewsToTheControl()
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.becomeFirstResponder()
        addSubViewsToTheControl()
        configureViews()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        addSubViewsToTheControl()
        configureViews()
    }
}

//MARK: - Supporting Methods
extension PasscodeTextField {
    private func addSubViewsToTheControl() {
        self.backgroundColor = .clear
        addSubview(pinsStack)
    }
    
    /// Configures appearance of `pinStack` and his arrangedSubviews.
    private func configureViews() {
        for pinView in pinsStack.arrangedSubviews {
            pinView.removeFromSuperview()
        }
        
        for tag in 1...numberOfDigits {
            let pin = PINView(fontSize: pinViewFontSize)
            pin.tag = tag
            pin.translatesAutoresizingMaskIntoConstraints = false
            pinsStack.addArrangedSubview(pin)
        }
        
        addConstraints([
            pinsStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pinsStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pinsStack.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9, constant: 0)
        ])
        
        for pinnn in pinsStack.arrangedSubviews {
            guard let pin = pinnn as? PINView else { return }
            pinsStack.addConstraints([
                pin.heightAnchor.constraint(equalTo: pinsStack.heightAnchor, multiplier: 1),
                pin.widthAnchor.constraint(equalToConstant: pinViewWidth)
            ])
        }
        
        let firstItem = pinsStack.arrangedSubviews.first as? PINView
        firstItem?.isNext = true
    }
}

//MARK: UIKeyInput
extension PasscodeTextField: UIKeyInput {
    func insertText(_ text: String) {
        if nextTag < (numberOfDigits + 1) {
            for char in text {
                (viewWithTag(nextTag)! as! PINView).key = String(char)
                nextTag += 1
            }
            if nextTag == (numberOfDigits + 1) {
                self.text = ""
                for index in 1..<nextTag {
                    self.text += (viewWithTag(index)! as! PINView).key
                }
                self.sendActions(for: .editingDidEnd)
            }
        }
        self.sendActions(for: .editingChanged)
    }
    
    func deleteBackward() {
        if nextTag > 1 {
            nextTag -= 1
            (viewWithTag(nextTag)! as! PINView).key = ""
        }
    }
    
    /// Delete all text.
    func clear() {
        while nextTag > 1 {
            deleteBackward()
        }
    }
}
