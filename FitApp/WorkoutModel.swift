//
//  WorkoutModel.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/27/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ExerciseModel {
    
    
    var workout: [ExerciseModel]
    var date: String
    
    init(workout: [ExerciseModel], date: String) {
        self.workout = workout
        self.date = date
    }
    
    var dictValue: [String : Any] {
        
        return ["workout" : workout,
                "date" : date
        ]
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
            let workout = dict["workout"] as? [ExerciseModel],
            let date = dict["date"] as? String
            else {return nil}
        
        self.workout = workout
        self.date = date
        
    }
    
    
}
