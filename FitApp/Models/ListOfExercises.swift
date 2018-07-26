//
//  ListOfExercises.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/23/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import Foundation

class ListOfExercises {
    

    var listOfExercises = [Exercise]()

    var pushUp = Exercise(exerciseName: "Push Up", numberOfReps: [], numberOfSets: [], sectionNumber: 0, alreadyAdded: false)
    var pullUp = Exercise(exerciseName: "Pull Up", numberOfReps: [], numberOfSets: [], sectionNumber: 0, alreadyAdded: false)
    var squat = Exercise(exerciseName: "Squat", numberOfReps: [], numberOfSets: [], sectionNumber: 0, alreadyAdded: false)
    
    init(){
        listOfExercises.append(pushUp)
        listOfExercises.append(pullUp)
        listOfExercises.append(squat)
    }
    
    
    
}
