//
//  PomeloTimer.swift
//  Pomelo
//
//  Created by Amy Chin Siu Huang on 9/1/20.
//  Copyright © 2020 Amy Chin Siu Huang. All rights reserved.
//

import Foundation
import Firebase

enum Category: String {
    case math
    case science
    case humanities
    case lanaguage
    case other
}

class PomeloTimer {
    
    var subject: String
    var length: String
    var playlist: String
    var category: Category
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: Any]
        self.subject = snapshotValue["subject"] as! String
        self.length = snapshotValue["length"] as! String
        self.playlist = snapshotValue["playlist"] as! String
        self.category = .other
        if let category = snapshotValue["category"] {
            let categoryName = category as! String
            if categoryName == "math" {
                self.category = .math
            }
            else if categoryName == "science" {
                self.category = .science
            }
            else if categoryName == "humanities" {
                self.category = .humanities
            }
            else if categoryName == "language"{
                self.category = .lanaguage
            }
        }
    }
    
    init(subject: String, length: String, playlist: String, category: Category) {
        self.subject = subject
        self.length = length
        self.playlist = playlist
        self.category = category
    }
    
}
