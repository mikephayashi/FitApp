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
    
    init(weight: Int, height: Int, age: Int, gender: Int, date: String) {
        self.weight = weight
        self.height = height
        self.age = age
        self.gender = gender
        self.date = date
    }
    
    var dictValue: [String : Any] {
        
        return ["weight" : weight,
                "height" : height,
                "age" : age,
                "gender" : gender,
                "date" : date
        ]
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
            let weight = dict["weight"] as? Int,
            let height = dict["height"] as? Int,
            let age = dict["age"] as? Int,
            let gender = dict["gender"] as? Int,
            let date = dict["date"] as? String
            else {return nil}
        
        self.weight = weight
        self.height = height
        self.age = age
        self.gender = gender
        self.date = date
        
    }
    
    
}
