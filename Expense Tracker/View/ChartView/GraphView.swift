//
//  GraphView.swift
//  Expense Tracker
//
//  Created by isEmpty on 03.12.2020.
//

import UIKit

final class GraphView: UIView {
    //MARK: - Properties
    public var graphPoints: [Double] = []
    private var plate: PlateView!
    private lazy var graphHeight: CGFloat = {
        return frame.height  - GraphConstants.topBorder - GraphConstants.bottomBorder
    }()

    override func draw(_ rect: CGRect) {
        guard !graphPoints.isEmpty else { return }

        if graphPoints.count == 1 {
            drawSingleLine()
        } else {
            drawGraph()
        }
    }
        
    //MARK: - Initializators
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        isOpaque = false
        setupGestureRecognizer()
    }
}

//MARK: - Configure Layouts
extension GraphView {
    
    /// Draws a horizontal line in the center of the graph.
    private func drawSingleLine() {
        let graphPath = UIBezierPath()
        let yPoint = graphHeight / 2 + GraphConstants.topBorder
        let firstPoint = CGPoint(x: frame.minX + GraphConstants.margin, y: yPoint)
        let lastPoint = CGPoint(x: frame.maxX - GraphConstants.margin, y: yPoint)
        graphPath.move(to: firstPoint)
        graphPath.addLine(to: lastPoint)
        graphPath.lineWidth = 5
        (UIColor(hex: UserDefaults.standard.string(forKey: "startColor") ?? "") ?? #colorLiteral(red: 0.5607843137, green: 0.3058823529, blue: 0.8392156863, alpha: 1)).setStroke()
        graphPath.stroke()
        
        configureLineShadow(graphPath)
        guard let clippingPath = graphPath.copy() as? UIBezierPath else {
            return
        }
        configureShadowPath(clippingPath)
    }
    
    /// Draws a graph.
    private func drawGraph() {
        let graphPath = UIBezierPath()
        let firstPoint = calculatePoint(0)
        graphPath.move(to: firstPoint)
        
        for i in 1..<graphPoints.count {
            let nextPoint = calculatePoint(i)
            let previousPoint = calculatePoint(i-1)
            
            let curveShift = (nextPoint.x - previousPoint.x) * GraphConstants.delta
            let controlPoint1 = CGPoint(x: previousPoint.x + curveShift, y: previousPoint.y)
            let controlPoint2 = CGPoint(x: nextPoint.x - curveShift, y: nextPoint.y)
            
            graphPath.addCurve(to: nextPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        }
        graphPath.lineWidth = 5
        (UIColor(hex: UserDefaults.standard.string(forKey: "startColor") ?? "") ?? #colorLiteral(red: 0.5607843137, green: 0.3058823529, blue: 0.8392156863, alpha: 1)).setStroke()
        graphPath.stroke()
        
        configureLineShadow(graphPath)
        guard let clippingPath = graphPath.copy() as? UIBezierPath else {
            return
        }
        configureShadowPath(clippingPath)
    }
    
    /// Configure blur-shadow on the graph
    private func configureLineShadow(_ graphPath: UIBezierPath) {
        let shadowLayer = CALayer()
        shadowLayer.shadowPath = graphPath.cgPath.copy(strokingWithWidth: 5, lineCap: .round, lineJoin: .round, miterLimit: 0)
        shadowLayer.shadowColor = (UIColor(hex: UserDefaults.standard.string(forKey: "startColor") ?? "") ?? #colorLiteral(red: 0.5607843137, green: 0.3058823529, blue: 0.8392156863, alpha: 1)).withAlphaComponent(0.66).cgColor
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowOffset = .zero
        shadowLayer.shadowRadius = 6
        layer.insertSublayer(shadowLayer, at: 0)
    }
        
    /// Creates shadow under the graph
    private func configureShadowPath(_ clippingPath: UIBezierPath){
        guard let maxValue = graphPoints.max(),
              let indexOfMaxValue = graphPoints.firstIndex(of: maxValue) else {fatalError()}
        
        let yPoint = graphPoints.count == 1 ?
            (graphHeight / 2 + GraphConstants.topBorder) : (columnYPoint(indexOfMaxValue) - graphHeight)
        closeShadowPath(clippingPath)
        let endColor = UIColor(hex: UserDefaults.standard.string(forKey: "endColor") ?? "") ?? #colorLiteral(red: 0.345, green: 0.212, blue: 0.733, alpha: 1.000)
        let colors = [endColor.withAlphaComponent(0.15).cgColor, endColor.withAlphaComponent(0).cgColor]
        guard let newGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: [0, 1]) else {
            return
        }
        
        let graphStartPoint = CGPoint(x: GraphConstants.margin, y: yPoint)
        let graphEndPoint = CGPoint(x: GraphConstants.margin, y: frame.height)
        UIGraphicsGetCurrentContext()?.drawLinearGradient(
            newGradient,
            start: graphStartPoint,
            end: graphEndPoint,
            options: [])
    }
    
    /// Closes `UIBezierPath`.
    private func closeShadowPath(_ clippingPath: UIBezierPath) {
        if graphPoints.count == 1 {
            clippingPath.addLine(to: CGPoint(x: frame.maxX - GraphConstants.margin, y: frame.height))
            clippingPath.addLine(to: CGPoint(x: frame.minX + GraphConstants.margin, y: frame.height))
        } else {
            clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1), y: frame.height))
            clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: frame.height))
        }
        
        clippingPath.close()
        clippingPath.addClip()
    }
        
    /// Creates a plate with information about an item by index.
    private func configurePlate(_ index: Int, on point: CGPoint) {
        plate?.removeFromSuperview()
        plate = PlateView()
        plate.plateText = "\(graphPoints[index])"
        
        calculatePlateFrame(point)
        plate.setNeedsDisplay()
        addSubview(plate)
    }
    
    /// Calculates the size and location of the plate.
    /// Chooses whether the plaque should be reversed.
    private func calculatePlateFrame(_ point: CGPoint) {
        let plateWidth = plate.plateText.count * 10
        let plateSize = CGSize(width: plateWidth, height: 45)
        
        let xPosition = point.x - plateSize.width / 2
        var yPosition: CGFloat
        plate.reverse = point.y - plateSize.height < GraphConstants.topBorder
        
        if plate.reverse {
            yPosition = point.y - GraphConstants.circleDiameter
        } else {
            yPosition = point.y - plateSize.height + GraphConstants.circleDiameter
        }
        
        plate.frame = CGRect(origin: CGPoint(x: xPosition, y: yPosition), size: plateSize)
    }
}

//MARK: - Supporting Methods
extension GraphView {
        
    /// Calculates the position of each item on the graph
    private func calculatePoint(_ index: Int) -> CGPoint {
        return CGPoint(x: columnXPoint(index), y: columnYPoint(index))
    }
    
    /// Calculates the `X position` based on the column number.
    private func columnXPoint(_ column: Int) -> CGFloat {
        let graphWidth = frame.width - GraphConstants.margin * 2 - 5
        let spacing = graphWidth / CGFloat(graphPoints.count - 1)
        return CGFloat(column) * spacing + GraphConstants.margin + 2
    }
    
    /// Calculates the `Y position` based on the row number.
    private func columnYPoint(_ row: Int) -> CGFloat {
        guard let maxValue = graphPoints.max() else { fatalError() }
        let graphPoint = graphPoints[row]
        let yPoint = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
        return graphHeight + GraphConstants.topBorder - yPoint
    }
    
    ///Adds a tap gesture.
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    /// Creates a `plate` when you click on a `GraphView` area.
    /// If the graph has one value, the `plate` will be in the center.
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        if graphPoints.count == 1 {
            let graphWidth = frame.width - GraphConstants.margin * 2 - 5
            let centerX = graphWidth / 2 + GraphConstants.margin
            let centerY = graphHeight / 2 + GraphConstants.topBorder
            configurePlate(0, on: CGPoint(x: centerX, y: centerY))
        } else {
            let location = sender.location(in: self).x
            let pointStep = Int(frame.width) / graphPoints.count
            let numberOfPoint: Int = Int(location) / pointStep
            
            let nextPoint = calculatePoint(numberOfPoint)
            configurePlate(numberOfPoint, on: nextPoint)
        }
    }
}

//MARK: - GraphConstants
internal struct GraphConstants {
    static let delta:CGFloat = 0.4
    static let margin: CGFloat = 25.0
    static let topBorder: CGFloat = 85
    static let bottomBorder: CGFloat = 10
    static let circleDiameter: CGFloat = 6
}
