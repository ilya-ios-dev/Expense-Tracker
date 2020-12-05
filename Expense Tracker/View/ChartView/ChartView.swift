//
//  ChartView.swift
//  Expense Tracker
//
//  Created by isEmpty on 03.12.2020.
//

import UIKit

@IBDesignable
final class ChartView: UIView, UIGestureRecognizerDelegate {
    
    //MARK: - Properties
    private var graphView: GraphView!
    private var bottomStackView: UIStackView!
    private var scrollView: UIScrollView!
    private var stackView: UIStackView!
    
    public var chartModel: ChartModel! {
        didSet {
            guard !chartModel.points.isEmpty else { return }
            addLabels()
            configureGraphView()
            addSeparator()
            configureBottomStackView()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 25)
        UIColor.white.setFill()
        path.fill()
    }
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
}



//MARK: - Layouts

extension ChartView {
    
    private func configureGraphView() {
        graphView = GraphView()
        graphView.graphPoints = chartModel.points.map{$0.progress}
        graphView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(graphView)
        let graphWidth = CGFloat(chartModel.points.count * 70)
        graphView.widthAnchor.constraint(equalToConstant: graphWidth).isActive = true
    }
    
    private func configureBottomStackView() {
        bottomStackView = UIStackView()
        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fillEqually
        bottomStackView.translatesAutoresizingMaskIntoConstraints = true

        chartModel.points.forEach { (data) in
            let label = UILabel()
            label.text = String(data.step)
            label.font = UIFont.systemFont(ofSize: 16, weight: .light)
            label.textAlignment = .center
            label.textColor = #colorLiteral(red: 0.7254901961, green: 0.7411764706, blue: 0.7647058824, alpha: 1)
            bottomStackView.addArrangedSubview(label)
        }
        stackView.addArrangedSubview(bottomStackView)
        bottomStackView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.166).isActive = true
    }
    
    private func addSeparator() {
        let separator = UIView()
        separator.backgroundColor = #colorLiteral(red: 0.7254901961, green: 0.7411764706, blue: 0.7647058824, alpha: 1)
        stackView.addArrangedSubview(separator)
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func addLabels() {
        let netLabel = UILabel()
        netLabel.text = "Net balance"
        netLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        netLabel.textColor = #colorLiteral(red: 0.7254901961, green: 0.7411764706, blue: 0.7647058824, alpha: 1)
        netLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(netLabel)
        NSLayoutConstraint.activate([
            netLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            netLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        ])
        
        
        let balanceLabel = UILabel()
        balanceLabel.text = chartModel.balance
        balanceLabel.font = UIFont.systemFont(ofSize: 44, weight: .bold)
        balanceLabel.textColor = #colorLiteral(red: 0.1960784314, green: 0.2117647059, blue: 0.2588235294, alpha: 1)
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(balanceLabel)
        NSLayoutConstraint.activate([
            balanceLabel.leadingAnchor.constraint(equalTo: netLabel.leadingAnchor),
            balanceLabel.topAnchor.constraint(equalTo: netLabel.topAnchor, constant: 15)
        ])
    }
    
    private func configureView(){
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        ])
    }
}
