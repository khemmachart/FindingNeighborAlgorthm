//
//  Metric.swift
//  FindingNeighborAlgorthm
//
//  Created by Khemmachart Chutapetch on 1/7/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import UIKit

class Metric {
    
    var pathWay: [[Node]] = []
    
    required init(pathWay: [[Node]]) {
        self.pathWay = pathWay
    }
    
    // MARK: Traversal
    
    func startTraversal() {
        connectThePath()
        printConnectedPath()
        resetNodes()
        traversal()
    }
    
    func traversal() {
        for rows in pathWay {
            for node in rows {
                if node.visitedFlag {
                    continue
                }
                print("\(node.value) : \(travel(atNode: node))")
            }
        }
    }
    
    func resetNodes() {
        for rows in pathWay {
            for node in rows {
                node.visitedFlag = false
                node.displayLabel?.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    func travel(atNode node: Node) -> Int {
        
        var counter = 1
        node.visitedFlag = true
        node.displayLabel?.backgroundColor = UIColor.yellow
        
        if let leftNode = node.leftNode, !leftNode.visitedFlag {
            counter += travel(atNode: leftNode)
        }
        if let rightNode = node.rightNode, !rightNode.visitedFlag {
            counter += travel(atNode: rightNode)
        }
        if let topNode = node.upperNode, !topNode.visitedFlag {
            counter += travel(atNode: topNode)
        }
        if let bottomNode = node.lowerNode, !bottomNode.visitedFlag {
            counter += travel(atNode: bottomNode)
        }
        
        return counter
    }
    
    func connectThePath() {
        for (rowIndex, rows) in pathWay.enumerated() {
            for (colIndex, element) in rows.enumerated() {
                let point = Point(row: rowIndex, col: colIndex)
                if let left = getLeftNode(pathWay, atPoint: point) {
                    element.leftNode = left
                }
                if let right = getRightNode(pathWay, atPoint: point) {
                    element.rightNode = right
                }
                if let bottom = getLowwerNode(pathWay, atPoint: point) {
                    element.lowerNode = bottom
                }
                if let top = getUpperNode(pathWay, atPoint: point) {
                    element.upperNode = top
                }
                print("(\(rowIndex),\(colIndex)) -> \(element.value)", separator: "", terminator: ",  ")
            }
            print("")
        }
    }
    
    // MARK: Validate
    
    func getVerifyMetricResult() -> (result: Bool, description: String){
        if pathWay.count == 0 {
            return (false, "Methic is not defined")
        }
        let columnCounter = pathWay[0].count
        for row in pathWay {
            if row.count != columnCounter {
                return (false, "The array is not a metric")
            }
        }
        return (true, "")
    }
    
    // MARK: Getter
    
    func getLeftNode(_ arr: [[Node]], atPoint point: Point) -> Node? {
        if point.col == 0 {
            return nil
        }
        
        let leftpoint = Point(row: point.row, col: point.col - 1)
        return shouldReturn(nextpoint: leftpoint, fromPoint: point, fromArray: arr)
    }
    
    func getRightNode(_ arr: [[Node]], atPoint point: Point) -> Node? {
        if point.col >= arr[point.row].count -  1 {
            return nil
        }
        
        let rightPoint = Point(row: point.row, col: point.col + 1)
        return shouldReturn(nextpoint: rightPoint, fromPoint: point, fromArray: arr)
    }
    
    func getLowwerNode(_ arr: [[Node]], atPoint point: Point) -> Node? {
        if point.row >= arr.count -  1 {
            return nil
        }
        
        let bottomPoint = Point(row: point.row + 1, col: point.col)
        return shouldReturn(nextpoint: bottomPoint, fromPoint: point, fromArray: arr)
    }
    
    func getUpperNode(_ arr: [[Node]], atPoint point: Point) -> Node? {
        if point.row == 0 {
            return nil
        }
        
        let topPoint = Point(row: point.row - 1, col: point.col)
        return shouldReturn(nextpoint: topPoint, fromPoint: point, fromArray: arr)
    }
    
    func shouldReturn(nextpoint next: Point, fromPoint from: Point, fromArray arr: [[Node]]) -> Node? {
        if arr[next.row][next.col].value == arr[from.row][from.col].value {
            return arr[next.row][next.col]
        }
        return nil
    }
    
    // MARK: Print
    
    func printConnectedPath() {
        for rows in pathWay {
            for i in 0...2 {
                for element in rows {
                    switch i {
                    case 0:
                        element.upperNode != nil ? printElement(" | ") : printElement("   ")
                    case 1:
                        element.leftNode != nil  ? printElement("-")   : printElement(" ")
                        printElement("\(element.value)")
                        element.rightNode != nil ? printElement("-")   : printElement(" ")
                    case 2:
                        element.lowerNode != nil ? printElement(" | ") : printElement("   ")
                    default:
                        break
                    }
                }
                print("")
            }
        }
    }
    
    func printElement(_ divider: String) {
        print(divider, separator: "", terminator: "")
    }
    
}
