//
//  Date.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/27/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
