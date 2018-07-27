//
//  ListOfExercises.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/23/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import Foundation

class ListOfExercises {
    

    var listOfExercises = [ExerciseModel]()

    var pushUp = ExerciseModel(exerciseName: "Push Up", numberOfReps: [], numberOfSets: [], sectionNumber: 0, alreadyAdded: false, dateCreated: "")
    var pullUp = ExerciseModel(exerciseName: "Pull Up", numberOfReps: [], numberOfSets: [], sectionNumber: 0, alreadyAdded: false, dateCreated: "")
    var squat = ExerciseModel(exerciseName: "Squat", numberOfReps: [], numberOfSets: [], sectionNumber: 0, alreadyAdded: false, dateCreated: "")
    var legpress = ExerciseModel(exerciseName: "Leg Press", numberOfReps: [], numberOfSets: [], sectionNumber: 0, alreadyAdded: false, dateCreated: "")
    var sprint = ExerciseModel(exerciseName: "Sprint", numberOfReps: [], numberOfSets: [], sectionNumber: 0, alreadyAdded: false, dateCreated: "")
    
    init(){
        listOfExercises.append(pushUp)
        listOfExercises.append(pullUp)
        listOfExercises.append(squat)
        listOfExercises.append(legpress)
        listOfExercises.append(sprint)
    }
    
    
    
}
