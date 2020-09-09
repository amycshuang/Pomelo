//
//  Extensions.swift
//  Pomelo
//
//  Created by Amy Chin Siu Huang on 8/25/20.
//  Copyright © 2020 Amy Chin Siu Huang. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

extension UIColor {
    
    static let humanitiesPink = UIColor(red: 0.9451, green: 0.8118, blue: 0.8196, alpha: 1.0)
    static let mathBlue = UIColor(red: 0.7843, green: 0.8588, blue: 0.9412, alpha: 1.0)
    static let languageYellow = UIColor(red: 1, green: 0.9137, blue: 0.6941, alpha: 1.0)
    static let scienceGreen = UIColor(red: 0.7529, green: 0.9255, blue: 0.8627, alpha: 1.0)
    static let otherViolet = UIColor(red: 0.8667, green: 0.8706, blue: 1, alpha: 1.0)
    
    static let darkGray = UIColor(red: 0.3451, green: 0.4039, blue: 0.4627, alpha: 1.0)
    static let lightGray = UIColor(red: 0.6431, green: 0.6902, blue: 0.7412, alpha: 1.0)
    static let darkWhite = UIColor(red: 0.9373, green: 0.9373, blue: 0.9373, alpha: 1.0)
    static let lightWhite = UIColor(red: 0.9882, green: 0.9804, blue: 0.9804, alpha: 1.0)
    
    static let seaGreen = UIColor(red: 0.5333, green: 0.7922, blue: 0.8745, alpha: 0.47)
    static let niceBlue = UIColor(red: 0.6824, green: 0.8118, blue: 1, alpha: 1.0)
    
    static let timerGrayColor = UIColor(red: 0.3294, green: 0.3294, blue: 0.3294, alpha: 0.66)
    static let textFieldGray = UIColor(red: 0.9137, green: 0.9373, blue: 0.9569, alpha: 1.0)
    static let progressBottomColor = UIColor(red: 0.7686, green: 0.7686, blue: 0.7686, alpha: 1.0)
    
}

extension UIView {
    func fadeIn(button: GIDSignInButton, subLabel: UILabel) {
        UIView.animate(withDuration: 1.5) {
            self.alpha = 1
            UIView.animate(withDuration: 1.5) {
                subLabel.alpha = 1
                UIView.animate(withDuration: 2) {
                    button.alpha = 1
                }
            }
        }
    }
}

extension UITextField {
    
    func setLeftPadding(padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPadding(padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}
