//
//  HBLineDraw.swift
//  MovementApp
//
//  Created by HiteshBoricha on 09/11/21.
//  Copyright © 2021 Hitesh Boricha. All rights reserved.
//

import UIKit
class HBLineDraw: UIView,UIGestureRecognizerDelegate {
    var pointA: CGPoint = CGPoint.zero
    var pointB: CGPoint = CGPoint.zero
    var isMovingPoint: Bool = false
    var poitnOfMove: String = ""
    let line = HBLine.sharedLine
    var pointToMove = 0
    var baseColor: UIColor = UIColor.green
    var otherColor: UIColor = UIColor.black
    var storedLine: NSMutableArray = NSMutableArray()
    var lineWidth : CGFloat = 3.0
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override init (frame : CGRect) {
        super.init(frame : frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    func initialSetup() {
        
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleDoubleTapGesture(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(_:)))
        self.addGestureRecognizer(gesture)
        let panGesture : UIPanGestureRecognizer  = UIPanGestureRecognizer(target: self, action: #selector(self.movePointWithPan(_:)))
        panGesture.delegate = self
        self.addGestureRecognizer(panGesture)
        self.storedLine = NSMutableArray()
        self.line.removeLine()
        self.setNeedsLayout()
    }
    @objc func handleDoubleTapGesture(_ sender: UITapGestureRecognizer)
    {
        btnSaveTapped()
    }
    @objc func handleTapGesture(_ sender: UITapGestureRecognizer)
    {
        let touchPoint = sender.location(in: self)
        if pointA == .zero {
            pointA = touchPoint
            self.drawCircle(atPoint: touchPoint, withColor: otherColor)
        } else if pointB == .zero {
            pointB = touchPoint
            self.drawCircle(atPoint: touchPoint, withColor: otherColor)
            self.drawLine(startPoint: pointA, endPoint: pointB, withColor: otherColor)
            for dict in self.storedLine {
                let a: CGPoint = (dict as! NSDictionary).object(forKey: "pointA") as! CGPoint
                let b: CGPoint = (dict as! NSDictionary).object(forKey: "pointB") as! CGPoint
                
                self.drawCircle(atPoint: a, withColor: otherColor)
                self.drawCircle(atPoint: b, withColor: otherColor)
                self.drawLine(startPoint: a, endPoint: b, withColor: otherColor)
            }
        }
    }
    
    func drawCircle(atPoint point: CGPoint, withColor color: UIColor)
    {
        let path: UIBezierPath = UIBezierPath(arcCenter: point, radius: 8.0, startAngle: 0.0, endAngle: 360.0, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = lineWidth
        self.layer.addSublayer(shapeLayer)
    }
    
    func drawLine(startPoint start: CGPoint, endPoint end: CGPoint, withColor color: UIColor)
    {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = color.cgColor
        line.lineWidth = lineWidth
        line.lineJoin = CAShapeLayerLineJoin.round
        self.layer.addSublayer(line)
        self.getLine(first: self.pointA, second: self.pointB, view: self)
    }
    
    func getLine(first : CGPoint, second : CGPoint, view : UIView)
    {
        let vec1 = CGVector(dx: first.x - second.x, dy: first.y - second.y)
        let theta1: CGFloat = CGFloat(atan2f(Float(vec1.dy), Float(vec1.dx)))
        let result : CGFloat = (theta1 / .pi * 180)
        let final = String(format: "%.1f°", result)
        print(final)
        line.setLine(firstPoint: first, SecondPoint: second)
    }
    
    @objc func movePointWithPan(_ sender: UIPanGestureRecognizer)
    {
        let p = sender.location(in: self)
        if sender.state == .began {
            let d1 : CGFloat = sqrt((p.x - line.p1.x) * (p.x - line.p1.x) + (p.y - line.p1.y) * (p.y - line.p1.y))
            let d2 : CGFloat = sqrt((p.x - line.p2.x) * (p.x - line.p2.x) + (p.y - line.p2.y) * (p.y - line.p2.y))
            let tolerance : CGFloat = 15.0
            if d1 < tolerance {
                pointToMove = 1
            } else if d2 < tolerance {
                pointToMove = 2
            } else {
                pointToMove = 3
            }
        } else {
            if pointToMove == 1 {
                line.p1 = p
                self.pointA = p
            } else if pointToMove == 2 {
                line.p2 = p
                self.pointB = p
            }
            self.setNeedsDisplay()
            self.layer.sublayers?.removeAll()
            for dict in self.storedLine {
                let a: CGPoint = (dict as! NSDictionary).object(forKey: "pointA") as! CGPoint
                let b: CGPoint = (dict as! NSDictionary).object(forKey: "pointB") as! CGPoint
                self.drawCircle(atPoint: a, withColor: otherColor)
                self.drawCircle(atPoint: b, withColor: otherColor)
                self.drawLine(startPoint: a, endPoint: b, withColor: otherColor)
            }
            
            self.drawCircle(atPoint: self.pointA, withColor: otherColor)
            self.drawCircle(atPoint: self.pointB, withColor: otherColor)
            self.drawLine(startPoint: self.pointA, endPoint: self.pointB, withColor: otherColor)
        }
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool
    {
        if gestureRecognizer .isKind(of: UIPanGestureRecognizer.self) {
            let p = gestureRecognizer.location(in: self)
            let d1 : CGFloat = sqrt((p.x - line.p1.x) * (p.x - line.p1.x) + (p.y - line.p1.y) * (p.y - line.p1.y))
            let d2 : CGFloat = sqrt((p.x - line.p2.x) * (p.x - line.p2.x) + (p.y - line.p2.y) * (p.y - line.p2.y))
            let tolerance : CGFloat = 15.0
            return (d1 < tolerance) || (d2 < tolerance)
        }
        return true
    }
    
    func btnClearTapped()
    {
        self.pointA = CGPoint.zero
        self.pointB = CGPoint.zero
        self.setNeedsLayout()
        self.line.removeLine()
        self.layer.sublayers?.removeAll()
        if self.storedLine.count == 0 {
            
            let a: CGPoint = CGPoint.init(x: 0, y: 0)
            let b: CGPoint = CGPoint.init(x: 10, y: 0)
            self.drawCircle(atPoint: a, withColor: UIColor.clear)
            self.drawCircle(atPoint: b, withColor: UIColor.clear)
            self.drawLine(startPoint: a, endPoint: b, withColor: UIColor.clear)
        }
        
        for dict in self.storedLine {
            let a: CGPoint = (dict as! NSDictionary).object(forKey: "pointA") as! CGPoint
            let b: CGPoint = (dict as! NSDictionary).object(forKey: "pointB") as! CGPoint
            self.drawCircle(atPoint: a, withColor: otherColor)
            self.drawCircle(atPoint: b, withColor: otherColor)
            self.drawLine(startPoint: a, endPoint: b, withColor: otherColor)
        }
    }
    func btnSaveTapped()
    {
        self.storedLine.add(["pointA": self.pointA, "pointB": self.pointB as Any])
        self.pointA = CGPoint.zero
        self.pointB = CGPoint.zero
        self.line.removeLine()
        self.setNeedsLayout()
    }
    func btnResetDemoTapped()
    {
        self.storedLine.removeAllObjects()
        self.layer.sublayers?.removeAll()
        self.pointA = CGPoint.zero
        self.pointB = CGPoint.zero
        if self.storedLine.count == 0 {
            
            let a: CGPoint = CGPoint.init(x: 0, y: 0)
            let b: CGPoint = CGPoint.init(x: 10, y: 0)
            
            self.drawCircle(atPoint: a, withColor: UIColor.clear)
            self.drawCircle(atPoint: b, withColor: UIColor.clear)
            self.drawLine(startPoint: a, endPoint: b, withColor: UIColor.clear)
        }
        self.line.removeLine()
        self.setNeedsLayout()
    }
}
