//
//  UserMetricsService.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/26/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct UserMetricsService {
    
    static func updateUserMetrics(weight: Int, height: Int, age: Int, gender: Int) {
        
        let updateUserMetricVar = UserMetricsModel(weight: weight, height: height, age: age, gender: gender)
        let dict = updateUserMetricVar.dictValue
        
        let userMetricRef = Database.database().reference().child("userMetrics").child(User.current.uid).childByAutoId()
        userMetricRef.updateChildValues(dict)
        
        
    }
    
    
    static func pullAll() {
        let userMetricRef = Database.database().reference().child("userMetrics").child(User.current.uid)
            userMetricRef.observe( .value, with: {(snapshot) in
                for item in snapshot.children {
                    if let node = item as? DataSnapshot {
                        print(node.key) //Which node
                        let pullAllCreator = node.childSnapshot(forPath: "weight").value
                        print(pullAllCreator)
                        
                        //node.childSnapshot(forPath: "weight").setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
                        
                        //Note array to prevent pulling every time
                    }
                }
                
            })
    }
    
    
}

