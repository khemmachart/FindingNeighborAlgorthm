//
//  Node.swift
//  FindingNeighborAlgorthm
//
//  Created by Khemmachart Chutapetch on 1/7/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import UIKit

class Node {
    var value: Int = 0
    
    var upperNode: Node?
    var lowerNode: Node?
    var leftNode : Node?
    var rightNode: Node?
    
    var visitedFlag: Bool = false
    
    var displayLabel: UILabel?
    
    init(value: Int) {
        self.value = value
    }
}
