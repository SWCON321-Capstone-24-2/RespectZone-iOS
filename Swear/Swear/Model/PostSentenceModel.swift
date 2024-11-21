//
//  PostSentenceModel.swift
//  Swear
//
//  Created by 민 on 11/21/24.
//

import Foundation

struct PostSentenceModel {
    var levels: [Double]
    var score: Double
    var type: String
    
    init(levels: [Double] = [],
         score: Double = 0.0,
         type: String = ""
    ) {
        self.levels = levels
        self.score = score
        self.type = type
    }
}
