//
//  Font.swift
//  Pomelo
//
//  Created by Amy Chin Siu Huang on 9/1/20.
//  Copyright © 2020 Amy Chin Siu Huang. All rights reserved.
//

import Foundation
import UIKit

struct Font {
    enum RobotoFont: String {
        case light = "Roboto-Light"
        case thin = "Roboto-Thin"
        case regular = "Roboto-Regular"
        case medium = "Roboto-Medium"
        case bold = "Roboto-Bold"
        case black = "Roboto-Black"
    }
    static func robotoFont(font: RobotoFont, size: CGFloat) -> UIFont {
        return UIFont(name: font.rawValue, size: size)!
    }
}
