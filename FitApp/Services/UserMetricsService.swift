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
    
    static func writeUserMetrics(weight: Int, height: Int, age: Int, gender: Int, date: String) {
        
        let updateUserMetricsVar = UserMetricsModel(weight: weight, height: height, age: age, gender: gender, date: date)
        let dict = updateUserMetricsVar.dictValue
        
        let userMetricRef = Database.database().reference().child("userMetrics").child(User.current.uid).child(CalendarViewController.selectedDateVarString)
        userMetricRef.updateChildValues(dict)
        print("Selected date: \(CalendarViewController.selectedDateVarString)")
        
        let newMetric = UserMetricsModel(weight: weight as! Int, height: height as! Int, age: age as! Int, gender: gender as! Int, date: date as! String)
        userMetricsArray.append(newMetric)
        
    }
    
    static func updateUserMetrics(weight: Int, height: Int, age: Int, gender: Int, date: String){
        
        let userMetricRef = Database.database().reference().child("userMetrics").child(User.current.uid).child(CalendarViewController.selectedDateVarString)
        userMetricRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            userMetricRef.child("weight").setValue(weight)
            userMetricRef.child("height").setValue(height)
            userMetricRef.child("gender").setValue(age)
            userMetricRef.child("age").setValue(gender)
            userMetricRef.child("date").setValue(date)
            

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
                    print(weight)
                    print(height)
                    print(age)
                    print(gender)
                    print(date)
                    let pulledMetric = UserMetricsModel(weight: weight as! Int, height: height as! Int, age: age as! Int, gender: gender as! Int, date: date as! String)
                    self.userMetricsArray.append(pulledMetric)
                }
            }
            
        })
    }
    
    
}

