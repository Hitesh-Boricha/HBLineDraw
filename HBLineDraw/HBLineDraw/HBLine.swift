//
//  HBLine.swift
//  MovementApp
//
//  Created by HiteshBoricha on 09/11/21.
//  Copyright © 2021 Hitesh Boricha. All rights reserved.
//

import UIKit

class HBLine: NSObject
{
    var p1 : CGPoint = CGPoint()
    var p2 : CGPoint = CGPoint()
    
    static let sharedLine = HBLine()
    
    override init()
    {
        super.init()
        
        p1 = CGPoint(x: -10, y: -20)
        p2 = CGPoint(x: -10, y: -20)
    }
    
    func removeLine()
    {
        p1 = CGPoint(x: -10, y: -20)
        p2 = CGPoint(x: -10, y: -20)
    }
    
    func setLine(firstPoint : CGPoint, SecondPoint : CGPoint)
    {
        self.p1 = firstPoint
        self.p2 = SecondPoint
    }
    
    func valueOfLine() -> String
    {
        let vec1 = CGVector(dx: p1.x - p2.x, dy: p1.y - p2.y)
        let theta1: CGFloat = CGFloat(atan2f(Float(vec1.dy), Float(vec1.dx)))
        let result : CGFloat = (theta1 / .pi * 180)
        return String(format: "%.1f°", result)
    }
}

