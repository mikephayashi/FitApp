//
//  UserMetricsModel.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/26/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UserMetricsModel {
    
    var weight: Int
    var height: Int
    var age: Int
    var gender: Int
    var date: String
    var goal: Int
    var bodyPart: Int
    var workoutType: Int
    var checked: [Int]
    var volume: Int
    var lengthOfWorkout: Int
    var numberOfWeeks: Int
    
    init(weight: Int, height: Int, age: Int, gender: Int, date: String, goal: Int, bodyPart: Int, workoutType: Int, checked: [Int], volume: Int, lengthOfWorkout: Int, numberOfWeeks: Int) {
        self.weight = weight
        self.height = height
        self.age = age
        self.gender = gender
        self.date = date
        self.goal = goal
        self.bodyPart = bodyPart
        self.workoutType = workoutType
        self.checked = checked
        self.volume = volume
        self.lengthOfWorkout = lengthOfWorkout
        self.numberOfWeeks = numberOfWeeks
    }
    
    var dictValue: [String : Any] {
        
        return ["weight" : weight,
                "height" : height,
                "age" : age,
                "gender" : gender,
                "date" : date,
                "goal" : goal,
                "bodyPart" : bodyPart,
                "workoutType" : workoutType,
                "checked" : checked,
                "volume" : volume,
                "lengthOfWorkout": lengthOfWorkout,
            "numberOfWeeks" : numberOfWeeks
        ]
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
            let weight = dict["weight"] as? Int,
            let height = dict["height"] as? Int,
            let age = dict["age"] as? Int,
            let gender = dict["gender"] as? Int,
            let date = dict["date"] as? String,
            let goal = dict["goal"] as? Int,
            let bodyPart = dict["bodyPart"] as? Int,
            let workoutType = dict["workoutType"] as? Int,
            let checked = dict["checked"] as? [Int],
            let volume = dict["volume"] as? Int,
            let lengthOfWorkout = dict["lengthOfWorkout"] as? Int,
            let numberOfWeeks = dict["numberOfWeeks"] as? Int
            else {return nil}
        
        self.weight = weight
        self.height = height
        self.age = age
        self.gender = gender
        self.date = date
        self.goal = goal
        self.bodyPart = bodyPart
        self.workoutType = workoutType
        self.checked = checked
        self.volume = volume
        self.lengthOfWorkout = lengthOfWorkout
        self.numberOfWeeks = numberOfWeeks
        
    }
    
    
}
