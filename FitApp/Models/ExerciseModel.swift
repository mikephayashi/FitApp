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
    

    
    var exerciseName: String
    var numberOfReps: [Int]
    var numberOfSets: [Int]
    var sectionNumber: Int
    var alreadyAdded: Bool
    var dateCreated: String
    var bodyPart: String
    
    init(exerciseName: String, numberOfReps: [Int], numberOfSets: [Int], sectionNumber: Int, alreadyAdded: Bool, dateCreated: String, bodyPart: String){
        self.exerciseName = exerciseName
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
        self.sectionNumber = sectionNumber
        self.alreadyAdded = alreadyAdded
        self.dateCreated = dateCreated
        self.bodyPart = bodyPart
    }
    
    var dictValue: [String : Any] {
        
        return ["exerciseName" : exerciseName,
                "numberOfReps" : numberOfReps,
                "numberOfSets" : numberOfSets,
                "sectionNumber" : sectionNumber,
                "alreadyAdded" : alreadyAdded,
                "dateCreated" : dateCreated,
                "bodyPart" : bodyPart
        ]
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
            let exerciseName = dict["exerciseName"] as? String,
            let numberOfReps = dict["numberOfReps"] as? [Int],
            let numberOfSets = dict["numberOfSets"] as? [Int],
            let sectionNumber = dict["sectionNumber"] as? Int,
            let alreadyAdded = dict["alreadyAdded"] as? Bool,
            let dateCreated = dict["dateCreated"] as? String,
            let bodyPart = dict["bodyPart"] as? String
            else {return nil}
        
        self.exerciseName = exerciseName
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
        self.sectionNumber = sectionNumber
        self.alreadyAdded = alreadyAdded
        self.dateCreated = dateCreated
        self.bodyPart = bodyPart
        
    }
    
}
