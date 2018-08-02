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
}

class SetDataCell: UITableViewCell{
    
    @IBOutlet weak var setNumberLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var numberOfRepsTextField: UITextField!
    
     weak var delegate: SetDataCellDelegate?
    
    @IBAction func weightTextFieldTapped(_ sender: Any) {
        guard let cell = (sender as AnyObject).superview??.superview as? SetDataCell else { return}
        delegate?.savingWeight(cell: cell, weight: Int(weightTextField.text!)!)
        
    }
    
    @IBAction func numberOfRepsTextFieldTapped(_ sender: Any) {
        guard let cell = (sender as AnyObject).superview??.superview as? SetDataCell else { return}
        delegate?.reloadingNumberOfReps(cell: cell, numberOfReps: Int(numberOfRepsTextField.text!)!)
    }
    
    
    @IBAction func deleteRowButtonTapped(_ sender: Any) {
        guard let cell = (sender as AnyObject).superview??.superview as? SetDataCell else { return}
        delegate?.deleteRow(cell: cell)
    }
    
    
}
