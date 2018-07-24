//
//  Exercise.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/23/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit

class Exercise {
    
    var exerciseName: String
    var numberOfReps: [Int]
    var numberOfSets: [Int]
    var sectionNumber: Int
    
    init(exerciseName: String, numberOfReps: [Int], numberOfSets: [Int], sectionNumber: Int){
        self.exerciseName = exerciseName
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
        self.sectionNumber = sectionNumber
    }
    
}
