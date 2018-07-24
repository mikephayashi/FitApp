//
//  AddingSet.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/23/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit

protocol AddingSetCellDelegate: class {
    func reloadingNumberOfSets(cell: AddingSetCell)
}

class AddingSetCell: UITableViewCell{
    
    @IBOutlet weak var addingSetButton: UIButton!
    
    weak var delegate: AddingSetCellDelegate?
    
    @IBAction func addingSetTapped(_ sender: Any) {
        guard let cell = (sender as AnyObject).superview??.superview as? AddingSetCell else { return}
        delegate?.reloadingNumberOfSets(cell: cell)
    }
    
}
