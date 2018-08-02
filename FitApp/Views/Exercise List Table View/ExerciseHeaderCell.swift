//
//  ExerciseHeader.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/23/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit

protocol ExerciseHeaderCellDelegate: class {
    
    func deleteExercise(cell: ExerciseHeaderCell)
    
}

class ExerciseHeaderCell: UITableViewCell{
    
    weak var delegate: ExerciseHeaderCellDelegate?
    
    
    @IBAction func deleteExerciseButtonTapped(_ sender: Any) {
        guard let cell = (sender as AnyObject).superview??.superview as? ExerciseHeaderCell else { return}
        delegate?.deleteExercise(cell: cell)
    }
    
}
