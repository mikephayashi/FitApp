//
//  CalculateUserMetrics.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/25/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import Foundation

protocol CalculateUserMetricsDelegate: class {
    func calculateWorkouts(weight: Int, height: Int, age: Int, gender: Int)
}

class CalculateUserMetrics {
    
    var weightInput: Int!
    var heightInput: Int!
    var ageInput: Int!
    var genderInput: Int!
    
    var delegate: CalculateUserMetricsDelegate?
    
}

extension CalculateUserMetrics: UserMetricsDelegate{
    func outputWorkouts(weight: Int, height: Int, age: Int, gender: Int) {
        weightInput = weight
        heightInput = height
        ageInput = age
        genderInput = gender
        
    }
    
    
    
    
}
