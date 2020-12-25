//
//  PinView.swift
//  Expense Tracker
//
//  Created by isEmpty on 23.12.2020.
//

import UIKit

/// View showing progress in CustomTextField.
final class PINView: UIView {
    
    //MARK: - Properties
    private var label: UILabel!
    private var bottomView: UIView!
    
    var key: String = "" {
        didSet{
            viewHasChanges()
        }
    }
    
    var hasText: Bool {
        return key != ""
    }
    
    var isNext: Bool = false {
        didSet{
            if isNext {
                bottomView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
                label.textColor = UIColor.white
            } else {
                bottomView.backgroundColor = UIColor.white.withAlphaComponent(0.25)
                label.textColor = UIColor.white.withAlphaComponent(0.25)
            }
        }
    }
    
    //MARK: - Initializations
    convenience init(fontSize: CGFloat) {
        self.init()
        changeFontSize(fontSize)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        viewHasChanges()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configure the appearance of views.
    private func configureViews(){
        let stackView = UIStackView()
        stackView.isUserInteractionEnabled = false
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.fillSuperview()
        
        label = UILabel()
        label.isUserInteractionEnabled = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 33, weight: .semibold)
        label.text = key
        label.textColor = UIColor.white.withAlphaComponent(0.25)
        stackView.addArrangedSubview(label)
        
        bottomView = UIView()
        bottomView.isUserInteractionEnabled = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.layer.cornerRadius = 2
        bottomView.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        stackView.addArrangedSubview(bottomView)
        bottomView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    /// Changes the appearance of the pinView depending on whether it is full.
    private func viewHasChanges() {
        if hasText {
            UIView.animate(withDuration: 0.5) {
                self.label.text = self.key
                self.label.textColor = .white
                self.bottomView.alpha = 0
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.label.text = "•"
                self.bottomView.alpha = 1
            }
        }
    }
    
    /// Changes the fontSize of the label.
    private func changeFontSize(_ fontSize: CGFloat) {
        guard let label = label else { return }
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
    }
}
