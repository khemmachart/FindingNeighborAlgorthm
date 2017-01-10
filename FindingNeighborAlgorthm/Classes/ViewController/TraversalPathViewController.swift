//
//  TraversalPathViewController.swift
//  FindingNeighborAlgorthm
//
//  Created by Khemmachart Chutapetch on 1/7/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import UIKit

class TraversalPathViewController: UIViewController {
    
    // Uncomment these lines below 
    // to fixed your onw array
    
    var fixedArray: [[Int]]? = [
        // [1,0,0,1,3,3],
        // [1,2,0,1,3,1],
        // [2,1,0,1,1,1],
        // [2,1,1,4,1,1],
        // [1,2,1,2,2,1],
        // [2,1,1,1,1,1],
    ]
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    var arr: [[Int]] = []
    var rowsNo: Int = 4
    var colsNo: Int = 4
    
    var horizontalStackView: UIStackView = UIStackView()
    var labels: [[UILabel]] = []
    var metric: Metric!
    
    @IBOutlet var displayResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialView()
        self.displayResultLabel.text = "Select a node below"
    }
    
    func initialView() {
        self.initArray()
        self.setInterface()
        self.initialMetric()
        self.mapLabelWithNode()
    }
    
    func initArray() {
        
        if let fixedArray = fixedArray, fixedArray.count > 0 {
            arr = fixedArray
            return
        }
        
        arr = []
        
        for i in 0..<rowsNo {
            arr.append([])
            for _ in 0..<colsNo {
                arr[i].append(Int(arc4random_uniform(4)))
            }
        }
    }
    
    func initialMetric() {
        let pathWay = arr.map{ $0.map{ Node(value: $0) } }
        self.metric = Metric(pathWay: pathWay)
        
        let result = metric.getVerifyMetricResult()
        
        if result.result {
            metric.startTraversal()
            metric.resetNodes()
        }
        else {
            self.showAlert(message: result.description)
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func mapLabelWithNode() {
        for (rowIndex, row) in labels.enumerated() {
            for (colIndex, label) in row.enumerated() {
                metric.pathWay[rowIndex][colIndex].displayLabel = label
            }
        }
    }
    
    func setInterface() {
        
        labels = []
        horizontalStackView.removeFromSuperview()
        
        // Vertical stack View
        horizontalStackView = getStackView(.vertical)
        for row in 0...arr.count - 1 {
            
            labels.append([])

            // Horizontal stack View
            let verticalStackView = getStackView(.horizontal)
            for col in 0...arr[row].count - 1 {
                
                //Text Label
                let width = self.view.frame.width / CGFloat(arr[row].count) - 2
                let textLabel = getTextLabel("\(arr[row][col])", width: width)
                
                verticalStackView.addArrangedSubview(textLabel)
                labels[row].append(textLabel)
            }
            
            horizontalStackView.addArrangedSubview(verticalStackView)
        }
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.view.addSubview(horizontalStackView)
        
        //Constraints
        horizontalStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        horizontalStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func getStackView(_ axis: UILayoutConstraintAxis) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.distribution  = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.center
        stackView.backgroundColor = UIColor.brown
        stackView.spacing = 2
        return stackView
    }
    
    func getTapGesture() -> UITapGestureRecognizer {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapResponse(_:)))
        tapGesture.numberOfTapsRequired = 1
        return tapGesture
    }
    
    func tapResponse(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let label = gestureRecognizer.view as? UILabel else { return }
        for (rowIndex, row) in labels.enumerated() {
            for (colIndex, col) in row.enumerated() {
                let eachLabel = labels[rowIndex][colIndex]
                if label == eachLabel {
                    traversalBySelectedNode(rowIndex: rowIndex, colIndex: colIndex)
                }
            }
        }
    }
    
    func traversalBySelectedNode(rowIndex: Int, colIndex: Int) {
        metric.resetNodes()
        
        let node = metric.pathWay[rowIndex][colIndex]
        let value = metric.travel(atNode: node)
        
        let resultText = "Node: \(node.value) - point : (\(rowIndex),\(colIndex))\nArea: \(value)"
        self.displayResultLabel.text = resultText
        
        print(resultText)
    }
    
    func getTextLabel(_ text: String, width: CGFloat) -> UILabel {
        let textLabel = UILabel()
        textLabel.backgroundColor = UIColor.lightGray
        textLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        textLabel.text = text
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 12)
        textLabel.isUserInteractionEnabled =  true
        textLabel.addGestureRecognizer(getTapGesture())
        return textLabel
    }
    
    // MARK: - Action
    
    @IBAction func randomNewArray(_ sender: UIButton) {
        self.initialView()
    }
}
