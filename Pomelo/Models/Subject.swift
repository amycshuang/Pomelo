//
//  Subject.swift
//  Pomelo
//
//  Created by Amy Chin Siu Huang on 9/6/20.
//  Copyright © 2020 Amy Chin Siu Huang. All rights reserved.
//

import Foundation
import UIKit

enum SubjectType: String {
    case math
    case science
    case humanities
    case language
    case other
}

class Subject {
    
    var subject: SubjectType
    var isSelected: Bool
    
    init(subject: SubjectType, isSelected: Bool) {
        self.subject = subject
        self.isSelected = isSelected
    }
    
    func getSubject() -> String {
        switch subject {
        case .math:
            return "math"
        case .science:
            return "science"
        case .humanities:
            return "humanities"
        case .language:
            return "language"
        case .other:
            return "other"
        }
    }
        
    func getSubjectColor() -> UIColor {
        switch subject {
        case .math:
            return .mathBlue
        case .science:
            return .scienceGreen
        case .humanities:
            return .humanitiesPink
        case .language:
            return .languageYellow
        case .other:
            return .otherViolet
        }
    }
}
