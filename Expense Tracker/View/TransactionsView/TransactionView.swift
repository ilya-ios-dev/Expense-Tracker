//
//  TransactionView.swift
//  Expense Tracker
//
//  Created by isEmpty on 18.12.2020.
//

import UIKit

open class TransactionView: UIView {

    private var overalStackView: UIStackView!
    public var transactionKindView: UIView!
    public var transactionIconLabel: UILabel!
    private var transactionAmountStackView: UIStackView!
    public var transactionKindLabel: UILabel!
    public var transactionAmountLabel: UILabel!
    
    open override func draw(_ rect: CGRect) {
        transactionKindView.layer.cornerRadius = transactionKindView.frame.height / 2
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 9)
        Colors.tabBarColor.setFill()
        path.fill()
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = path.cgPath // Reuse the Bezier path
        borderLayer.fillColor = UIColor.clear.cgColor

        borderLayer.strokeColor = Colors.borderColor.cgColor
        borderLayer.lineWidth = 1
        borderLayer.frame = rect
        layer.addSublayer(borderLayer)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
    }
}

//MARK: - Configure Layouts
extension TransactionView {
    private func configureViews(){
        configureOveralStackView()
        configureTransactionKindView()
        configureTransactionIconLabel()
        configureTransactionAmountStackView()
        configureTransactionKindLabel()
        configureTransactionAmountLabel()
    }

    private func configureOveralStackView() {
        overalStackView = UIStackView()
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
        transactionKindView.translatesAutoresizingMaskIntoConstraints = false
        overalStackView.addArrangedSubview(transactionKindView)
        transactionKindView.widthAnchor.constraint(equalToConstant: 42).isActive = true
        transactionKindView.aspectRatio(multiplier: 1).isActive = true
    }
    
    private func configureTransactionIconLabel() {
        transactionIconLabel = UILabel()
        transactionIconLabel.textColor = .white
        transactionIconLabel.font = UIFont.systemFont(ofSize: 21, weight: .light)
        transactionIconLabel.textAlignment = .center
        transactionKindView.addSubview(transactionIconLabel)
        transactionIconLabel.fillSuperview()
    }
    
    private func configureTransactionAmountStackView() {
        transactionAmountStackView = UIStackView()
        transactionAmountStackView.axis = .vertical
        transactionAmountStackView.alignment = .leading
        transactionAmountStackView.distribution = .fill
        transactionAmountStackView.spacing = 10
        overalStackView.addArrangedSubview(transactionAmountStackView)
    }
    
    private func configureTransactionKindLabel() {
        transactionKindLabel = UILabel()
        transactionKindLabel.textColor = Colors.descriptionColor
        transactionKindLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        transactionAmountStackView.addArrangedSubview(transactionKindLabel)
    }
    
    private func configureTransactionAmountLabel() {
        transactionAmountLabel = UILabel()
        transactionAmountLabel.textColor = UIColor.label
        transactionAmountLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        transactionAmountLabel.adjustsFontSizeToFitWidth = true
        transactionAmountLabel.minimumScaleFactor = 0.5
        
        transactionAmountStackView.addArrangedSubview(transactionAmountLabel)
    }
}
