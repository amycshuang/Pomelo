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
    
    static let pomeloPink = UIColor(red: 1, green: 0.4667, blue: 0.4667, alpha: 1.0)
    
}

extension UIView {
    func fadeIn(button: GIDSignInButton) {
        UIView.animate(withDuration: 1.5) {
            self.alpha = 1
            UIView.animate(withDuration: 1.5) {
                button.alpha = 1
            }
        }
    }
}
