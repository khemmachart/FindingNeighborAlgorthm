//
//  ViewController.swift
//  FindingNeighborAlgorthm
//
//  Created by Khemmachart Chutapetch on 1/7/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import UIKit

class SelectDimesionViewController: UIViewController {

    @IBOutlet weak var rowIncreaseButton: UIButton!
    @IBOutlet weak var rowDecreaseButton: UIButton!
    
    @IBOutlet weak var colIncreaseButton: UIButton!
    @IBOutlet weak var colDecreaseButton: UIButton!
    
    @IBOutlet weak var rowLabel: UILabel!
    @IBOutlet weak var colLabel: UILabel!
    
    let minimumValue: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBorder(rowLabel)
        self.setBorder(colLabel)
        self.setBorder(rowIncreaseButton)
        self.setBorder(rowDecreaseButton)
        self.setBorder(colIncreaseButton)
        self.setBorder(colDecreaseButton)
    }
    
    func setBorder(_ view: UIView) {
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
    }
    
    @IBAction func changeValueButtonDidPress(_ sender: UIButton) {
        switch sender {
        case rowIncreaseButton:
            increaseValue(ofLabel: rowLabel)
        case rowDecreaseButton:
            decreaseValue(ofLabel: rowLabel)
        case colIncreaseButton:
            increaseValue(ofLabel: colLabel)
        case colDecreaseButton:
            decreaseValue(ofLabel: colLabel)
        default:
            break
        }
    }
    
    func increaseValue(ofLabel label: UILabel) {
        if let text = label.text, let value = Int(text) {
            label.text = "\(value + 1)"
        }
    }
    
    func decreaseValue(ofLabel label: UILabel) {
        if let text = label.text, let value = Int(text), value > minimumValue {
            label.text = "\(value - 1)"
        }
    }
    
    @IBAction func nextButtonDidPress(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "TraversalPathViewController") as? TraversalPathViewController else { return }
        if let col = Int(colLabel.text!), let row = Int(rowLabel.text!) {
            viewController.colsNo = col
            viewController.rowsNo = row
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
