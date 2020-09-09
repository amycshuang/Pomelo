//
//  CircularProgressBar.swift
//  Pomelo
//
//  Created by Amy Chin Siu Huang on 9/6/20.
//  Copyright © 2020 Amy Chin Siu Huang. All rights reserved.
//

import UIKit
import SnapKit

class CircularProgressBar: UIView {
    
    var shapeLayer: CAShapeLayer!
    let animationKey = "animationKey"

    override init(frame: CGRect) {
        super.init(frame: frame)

        let center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        shapeLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: center, radius: 115, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 1
        self.layer.addSublayer(shapeLayer)
    }
    
    func setLineColor(color: UIColor) {
        shapeLayer.strokeColor = color.cgColor
    }
    
    func animateProgressBar(duration: CFTimeInterval) {
        let progressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        progressAnimation.toValue = 1
        progressAnimation.duration = duration
        progressAnimation.fillMode = CAMediaTimingFillMode.forwards
        progressAnimation.isRemovedOnCompletion = false
        shapeLayer.add(progressAnimation, forKey: animationKey)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
