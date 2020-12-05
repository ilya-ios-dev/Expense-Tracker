//
//  GraphView.swift
//  Expense Tracker
//
//  Created by isEmpty on 03.12.2020.
//

import UIKit

final class GraphView: UIView {
    
    //MARK: - Properties
    public var graphPoints: [Int] = []
    private var graphWidth: CGFloat!
    private var graphHeight: CGFloat!
    private var rectWidth : CGFloat!
    private var rectHeight : CGFloat!
    private var context: CGContext!
    
    private var plate = PlateView()
    
    override func draw(_ rect: CGRect) {
        context = UIGraphicsGetCurrentContext()
        
        rectWidth = rect.width
        rectHeight = rect.height
        graphWidth = rect.width  - GraphConstants.margin * 2 - 5
        graphHeight = rect.height  - GraphConstants.topBorder - GraphConstants.bottomBorder
                
        guard !graphPoints.isEmpty else {
            return
        }
        
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
        #colorLiteral(red: 0.5568627451, green: 0.3215686275, blue: 0.8352941176, alpha: 1).setStroke()
        graphPath.stroke()
        
        addLineShadow(graphPath)
        
        guard let clippingPath = graphPath.copy() as? UIBezierPath else {
            return
        }

        addshadowPath(clippingPath)
        

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
        configureGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        isOpaque = false
        configureGesture()
    }
}



//MARK: - Layouts

extension GraphView {
    
    //Creates blur-shadow on the graph
    private func addLineShadow(_ graphPath: UIBezierPath) {
        let shadowLayer = CALayer()
        
        shadowLayer.shadowPath = graphPath.cgPath.copy(strokingWithWidth: 5, lineCap: .round, lineJoin: .round, miterLimit: 0)
        shadowLayer.shadowColor = #colorLiteral(red: 0.4549019608, green: 0.2666666667, blue: 0.7725490196, alpha: 0.6625299813).cgColor
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowOffset = .zero
        shadowLayer.shadowRadius = 6
        
        layer.insertSublayer(shadowLayer, at: 0)
    }

    //Creates shadow under the graph
    private func addshadowPath(_ clippingPath: UIBezierPath){
        guard let maxValue = graphPoints.max() else { fatalError() }
        
        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1), y: rectHeight))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: rectHeight))
        clippingPath.close()
        clippingPath.addClip()
        
        let highestYPoint =  columnYPoint(maxValue) - graphHeight
        let graphStartPoint = CGPoint(x: GraphConstants.margin, y: highestYPoint)
        let graphEndPoint = CGPoint(x: GraphConstants.margin, y: rectHeight)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0, 1]
        
        let colors = [#colorLiteral(red: 0.3725490196, green: 0.2274509804, blue: 0.7450980392, alpha: 0.15).cgColor, #colorLiteral(red: 0.5607843137, green: 0.3019607843, blue: 0.8352941176, alpha: 0).cgColor]
        guard let newGradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations) else { return }
        
        context.drawLinearGradient(
            newGradient,
            start: graphStartPoint,
            end: graphEndPoint,
            options: [])
    }
}



//MARK: - Supporting Methods

extension GraphView {
    
    private func addPlate(_ index: Int, on point: CGPoint) {
        plate.removeFromSuperview()
        
        let text = "\(graphPoints[index])"
        
        plate.plateText = "$\(text)"
        let plateSize = CGSize(width: 49, height: 45)
        
        let xPosition = point.x - plateSize.width / 2
        let yPosition = point.y - plateSize.height + GraphConstants.circleDiameter
        let origin = CGPoint(x: xPosition, y: yPosition)
        
        plate.frame = CGRect(origin: origin, size: plateSize)
        addSubview(plate)
    }
    
    //Calculates the position of each item on the graph
    private func calculatePoint(_ index: Int) -> CGPoint {
        return CGPoint(x: columnXPoint(index), y: columnYPoint(index))
    }
        
    //Calculate X Point on the chart
    private func columnXPoint(_ column: Int) -> CGFloat {
        let spacing = graphWidth / CGFloat(graphPoints.count - 1)
        return CGFloat(column) * spacing + GraphConstants.margin + 2
    }
    
    //Calculate Y Point on the chart
    private func columnYPoint(_ row: Int) -> CGFloat {
        guard let maxValue = graphPoints.max() else { fatalError() }
        let graphPoint = graphPoints[row]
        let yPoint = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
        return graphHeight + GraphConstants.topBorder - yPoint
    }
    
    
    private func configureGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self).x
        let pointStep = Int(rectWidth) / graphPoints.count
        let numberOfPoint: Int = Int(location) / pointStep
        
        let nextPoint = calculatePoint(numberOfPoint)
        addPlate(numberOfPoint, on: nextPoint)
    }
    
    private struct GraphConstants {
        static let delta:CGFloat = 0.4
        static let margin: CGFloat = 25.0
        static let topBorder: CGFloat = 85
        static let bottomBorder: CGFloat = 10
        static let circleDiameter: CGFloat = 6
    }
}

