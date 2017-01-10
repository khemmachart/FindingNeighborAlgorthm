//
//  Point.swift
//  FindingNeighborAlgorthm
//
//  Created by Khemmachart Chutapetch on 1/7/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import Foundation

struct Point {
    var row: Int!
    var col: Int!
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    func getDescription() -> String {
        if let row = self.row, let col = self.col {
            return "(\(row),\(col))"
        }
        return ""
    }
}
