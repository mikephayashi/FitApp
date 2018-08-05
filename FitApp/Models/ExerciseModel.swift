//
//  Exercise.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/23/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ExerciseModel {
    
    enum BodyPart: String {
        case chest = "Chest",
        back = "Back",
        bicep = "Biceps",
        tricep = "Triceps",
        delt = "Delts",
        abs = "Abs",
        quads = "Quads",
        hamstrings = "Hamstrings",
        calves = "Calves",
        cardio = "Cardio",
        olympicLifts = "Olympic Lifts"

    }
    
    enum Intensity: String {
        case technical = "technical",
        ballistic = "ballistic",
        primary = "primary",
        accesory = "accesory"
    }
    
    enum Sport: String {
        case general = "general",
        fatLoss = "fastLoss",
        bodyBuilding = "bodyBuilding",
        running = "running",
        crossfit = "crossfit",
        martialArts = "martialArts"
    }
    
    enum WorkoutType: String {
        case foundational = "foundational",
        cardio = "cardio",
        strength = "strength"
    }

    
    var exerciseName: String
    var numberOfReps: [Int]
    var numberOfSets: [Int]
    var weight: [Int]
    var completed: [Int]
    var sectionNumber: Int
    var alreadyAdded: Bool
    var dateCreated: String
    var bodyPart: String
    var restDays: Int
    var intensity: String
    var workoutType: String
    
    init(exerciseName: String, numberOfReps: [Int], numberOfSets: [Int], weight: [Int], completed: [Int], sectionNumber: Int, alreadyAdded: Bool, dateCreated: String, bodyPart: String, restDays: Int, intensity: String, workoutType: String){
        self.exerciseName = exerciseName
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
        self.weight = weight
        self.completed = completed
        self.sectionNumber = sectionNumber
        self.alreadyAdded = alreadyAdded
        self.dateCreated = dateCreated
        self.bodyPart = bodyPart
        self.restDays = restDays
        self.intensity = intensity
        self.workoutType = workoutType
    }
    
    var dictValue: [String : Any] {
        
        return ["exerciseName" : exerciseName,
                "numberOfReps" : numberOfReps,
                "numberOfSets" : numberOfSets,
                "weight" : weight,
                "completed" : completed,
                "sectionNumber" : sectionNumber,
                "alreadyAdded" : alreadyAdded,
                "dateCreated" : dateCreated,
                "bodyPart" : bodyPart,
                "restDays" : restDays,
                "intensity" : intensity,
                "workoutType" : workoutType
        ]
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
            let exerciseName = dict["exerciseName"] as? String,
            let numberOfReps = dict["numberOfReps"] as? [Int],
            let numberOfSets = dict["numberOfSets"] as? [Int],
            let weight = dict["weight"] as? [Int],
            let completed = dict["completed"] as? [Int],
            let sectionNumber = dict["sectionNumber"] as? Int,
            let alreadyAdded = dict["alreadyAdded"] as? Bool,
            let dateCreated = dict["dateCreated"] as? String,
            let bodyPart = dict["bodyPart"] as? String,
            let restDays = dict["restDays"] as? Int,
            let intensity = dict["intensity"] as? String,
            let workoutType = dict["workoutType"] as? String
            else {return nil}
        
        self.exerciseName = exerciseName
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
        self.weight = weight
        self.completed = completed
        self.sectionNumber = sectionNumber
        self.alreadyAdded = alreadyAdded
        self.dateCreated = dateCreated
        self.bodyPart = bodyPart
        self.restDays = restDays
        self.intensity = intensity
        self.workoutType = workoutType
        
    }
    
}
