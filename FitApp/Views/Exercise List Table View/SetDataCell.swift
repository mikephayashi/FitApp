//
//  SetDataCell.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/23/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit

protocol SetDataCellDelegate: class {
    
    func reloadingNumberOfReps(cell: SetDataCell, numberOfReps: Int)
    
    func savingWeight(cell: SetDataCell, weight: Int)
    
    func deleteRow(cell: SetDataCell)
    
    func setCompleted(cell: SetDataCell, checked: Bool)
}

class SetDataCell: UITableViewCell{
    
    @IBOutlet weak var setNumberLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var numberOfRepsTextField: UITextField!
    @IBOutlet weak var checkBox: Checkbox!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    
     weak var delegate: SetDataCellDelegate?
    
    @IBAction func weightTextFieldTapped(_ sender: Any) {
        if weightTextField.text == "" {
            weightTextField.text = "0"
        }
        guard let cell = (sender as AnyObject).superview??.superview?.superview as? SetDataCell else { return}
        delegate?.savingWeight(cell: cell, weight: Int(weightTextField.text!)!)
        
    }
    
    @IBAction func numberOfRepsTextFieldTapped(_ sender: Any) {
        if numberOfRepsTextField.text == "" {
            numberOfRepsTextField.text = "1"
        }
        guard let cell = (sender as AnyObject).superview??.superview?.superview as? SetDataCell else { return}
        delegate?.reloadingNumberOfReps(cell: cell, numberOfReps: Int(numberOfRepsTextField.text!)!)
    }
    
    
    @IBAction func deleteRowButtonTapped(_ sender: Any) {
        guard let cell = (sender as AnyObject).superview??.superview?.superview as? SetDataCell else { return }
        delegate?.deleteRow(cell: cell)
    }
    
    @objc func checkboxValueChanged(sender: Checkbox) {
        print("checkbox value change: \(sender.isChecked)")
        guard let cell = (sender as AnyObject).superview??.superview?.superview as? SetDataCell else { return}
        delegate?.setCompleted(cell: cell, checked: checkBox.isChecked)
    }
    
    
}
