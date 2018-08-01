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

    //Upper Body
    var pushUp = ExerciseModel(exerciseName: "Push Up", numberOfReps: [1], numberOfSets: [1], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: "upperBody")
    var pullUp = ExerciseModel(exerciseName: "Pull Up", numberOfReps: [1], numberOfSets: [1], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: "upperBody")
    var chinUp = ExerciseModel(exerciseName: "Chin Up", numberOfReps: [1], numberOfSets: [1], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: "upperBody")
    
    //Lower Body
    var squat = ExerciseModel(exerciseName: "Squat", numberOfReps: [1], numberOfSets: [1], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: "lowerBody")
    var legPress = ExerciseModel(exerciseName: "Leg Press", numberOfReps: [1], numberOfSets: [1], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: "lowerBody")
    var sprint = ExerciseModel(exerciseName: "Sprint", numberOfReps: [1], numberOfSets: [1], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: "lowerBody")
    
    init(){
        listOfExercises.append(pushUp)
        listOfExercises.append(pullUp)
        listOfExercises.append(chinUp)
        listOfExercises.append(squat)
        listOfExercises.append(legPress)
        listOfExercises.append(sprint)
    }
    
    
    
}
