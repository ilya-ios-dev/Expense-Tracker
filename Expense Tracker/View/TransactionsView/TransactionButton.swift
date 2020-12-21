//
//  TransactionButton.swift
//  Expense Tracker
//
//  Created by isEmpty on 18.12.2020.
//

import UIKit

open class TransactionButton: UIButton {

    private var overalStackView: UIStackView!
    public var transactionKindView: UIView!
    public var transactionIconLabel: UILabel!
    private var transactionAmountStackView: UIStackView!
    public var transactionAmountLabel: UILabel!

    open override func draw(_ rect: CGRect) {
        transactionKindView.layer.cornerRadius = transactionKindView.frame.height / 2
                
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: 9).cgPath
        layer.mask = maskLayer

        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path // Reuse the Bezier path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        borderLayer.lineWidth = 1
        borderLayer.frame = rect
        layer.addSublayer(borderLayer)

    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
    }
    
    @objc private func buttonStartTapper(sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0.5
        }
    }
    
    @objc private func buttonEndTapped(sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
        }
    }
}

//MARK: - Configure Layouts
extension TransactionButton {
    private func configureViews(){
        configureOveralStackView()
        configureTransactionKindView()
        configureTransactionIconLabel()
        configureTransactionAmountStackView()
        configureTransactionAmountLabel()
        self.addTarget(self, action: #selector(buttonStartTapper(sender:)), for: .touchDown)
        self.addTarget(self, action: #selector(buttonEndTapped(sender:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(buttonEndTapped(sender:)), for: .touchUpOutside)
    }

    private func configureOveralStackView() {
        overalStackView = UIStackView()
        overalStackView.isUserInteractionEnabled = false
        overalStackView.axis = .vertical
        overalStackView.alignment = .leading
        overalStackView.distribution = .equalSpacing
        overalStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(overalStackView)
        NSLayoutConstraint.activate([
            overalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            overalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            overalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            overalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24)
        ])
    }
    
    private func configureTransactionKindView() {
        transactionKindView = UIView()
        transactionKindView.isUserInteractionEnabled = false
        transactionKindView.translatesAutoresizingMaskIntoConstraints = false
        overalStackView.addArrangedSubview(transactionKindView)
        transactionKindView.widthAnchor.constraint(equalToConstant: 42).isActive = true
        transactionKindView.aspectRatio(multiplier: 1).isActive = true
    }
    
    private func configureTransactionIconLabel() {
        transactionIconLabel = UILabel()
        transactionIconLabel.isUserInteractionEnabled = false
        transactionIconLabel.textColor = .white
        transactionIconLabel.font = UIFont.systemFont(ofSize: 21, weight: .light)
        transactionIconLabel.textAlignment = .center
        transactionKindView.addSubview(transactionIconLabel)
        transactionIconLabel.fillSuperview()
    }
    
    private func configureTransactionAmountStackView() {
        transactionAmountStackView = UIStackView()
        transactionAmountStackView.isUserInteractionEnabled = false
        transactionAmountStackView.axis = .vertical
        transactionAmountStackView.alignment = .leading
        transactionAmountStackView.distribution = .fill
        transactionAmountStackView.spacing = 10
        overalStackView.addArrangedSubview(transactionAmountStackView)
    }
        
    private func configureTransactionAmountLabel() {
        transactionAmountLabel = UILabel()
        transactionAmountLabel.isUserInteractionEnabled = false
        transactionAmountLabel.textColor = UIColor(hex: "#414654r")
        transactionAmountLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        transactionAmountLabel.adjustsFontSizeToFitWidth = true
        transactionAmountLabel.minimumScaleFactor = 0.5
        
        transactionAmountStackView.addArrangedSubview(transactionAmountLabel)
    }
}
