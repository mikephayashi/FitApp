//
//  ExerciseSelectorCell.swift
//  FitApp
//
//  Created by Michael Hayashi on 8/3/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit

protocol ExerciseSelectorCellDelegate: class {
    
    func selectingExerciseTypes(cell: ExerciseSelectorCell, checked: Bool)

}

class ExerciseSelectorCell: UITableViewCell {
    
    @IBOutlet weak var exerciseName: UILabel!
    @IBOutlet weak var checkBox: Checkbox!
    
    weak var delegate: ExerciseSelectorCellDelegate?
    
    @objc func checkboxValueChanged(sender: Checkbox) {
        print("checkbox value change: \(sender.isChecked)")
        guard let cell = (sender as AnyObject).superview??.superview as? ExerciseSelectorCell else { return}
        delegate?.selectingExerciseTypes(cell: cell, checked: checkBox.isChecked)
    }
}


