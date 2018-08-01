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
    
    static var userMetricsArray = [UserMetricsModel]()
    
    static func writeUserMetrics(weight: Int, height: Int, age: Int, gender: Int, date: String, goal: Int, bodyPart: Int, volume: Int, lengthOfWorkout: Int, numberOfWeeks: Int) {
        
        let updateUserMetricsVar = UserMetricsModel(weight: weight, height: height, age: age, gender: gender, date: date, goal: goal, bodyPart: bodyPart, volume: volume, lengthOfWorkout: lengthOfWorkout, numberOfWeeks: numberOfWeeks)
        let dict = updateUserMetricsVar.dictValue
        
        let userMetricRef = Database.database().reference().child("userMetrics").child(User.current.uid).child(CalendarViewController.selectedDateVarString)
        userMetricRef.updateChildValues(dict)
        print("Selected date: \(CalendarViewController.selectedDateVarString)")
        
        let newMetric = UserMetricsModel(weight: weight as! Int, height: height as! Int, age: age as! Int, gender: gender as! Int, date: date as! String, goal: goal as! Int, bodyPart: bodyPart as! Int, volume : volume as! Int, lengthOfWorkout: lengthOfWorkout as! Int, numberOfWeeks: numberOfWeeks as! Int)
        userMetricsArray.append(newMetric)
        
    }
    
    static func updateUserMetrics(weight: Int, height: Int, age: Int, gender: Int, date: String, goal: Int, bodyPart: Int, volume: Int, lengthOfWorkout: Int, numberOfWeeks: Int){
        
        let userMetricRef = Database.database().reference().child("userMetrics").child(User.current.uid).child(CalendarViewController.selectedDateVarString)
        userMetricRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            userMetricRef.child("weight").setValue(weight)
            userMetricRef.child("height").setValue(height)
            userMetricRef.child("gender").setValue(age)
            userMetricRef.child("age").setValue(gender)
            userMetricRef.child("date").setValue(date)
            userMetricRef.child("goal").setValue(goal)
            userMetricRef.child("bodyPart").setValue(bodyPart)
            userMetricRef.child("volume").setValue(volume)
            userMetricRef.child("lengthOfWorkout").setValue(lengthOfWorkout)
            userMetricRef.child("numberOfWeeks").setValue(numberOfWeeks)

        })
    }
    
    
    static func pullAll() {
        
        let userMetricsRef = Database.database().reference().child("userMetrics").child(User.current.uid)
        userMetricsRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for item in snapshot.children {
                if let node = item as? DataSnapshot {
                    print(node.key) //Which node
                    let weight = node.childSnapshot(forPath: "weight").value
                    let height = node.childSnapshot(forPath: "height").value
                    let age = node.childSnapshot(forPath: "age").value
                    let gender = node.childSnapshot(forPath: "gender").value
                    let date = node.childSnapshot(forPath: "date").value
                    let goal = node.childSnapshot(forPath: "goal").value
                    let bodyPart = node.childSnapshot(forPath: "bodyPart").value
                    let volume = node.childSnapshot(forPath: "volume").value
                    let lengthOfWorkout = node.childSnapshot(forPath: "lengthOfWorkout").value
                    let numberOfWeeks = node.childSnapshot(forPath: "numberOfWeeks").value
                    print(weight!)
                    print(height!)
                    print(age!)
                    print(gender!)
                    print(date!)
                    print(goal!)
                    print(bodyPart!)
                    print(numberOfWeeks!)
                    print(lengthOfWorkout!)
                    print(volume!)
                    let pulledMetric = UserMetricsModel(weight: weight as! Int, height: height as! Int, age: age as! Int, gender: gender as! Int, date: date as! String, goal: goal as! Int, bodyPart: bodyPart as! Int, volume: volume as! Int, lengthOfWorkout: lengthOfWorkout as! Int, numberOfWeeks: numberOfWeeks as! Int)
                    self.userMetricsArray.append(pulledMetric)
                }
            }
            
        })
    }
    
    
}

