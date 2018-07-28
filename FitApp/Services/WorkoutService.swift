//
//  WorkoutService.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/27/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct WorkoutService {
    
    static var currentSectionNumber = "0"
    static var workoutArray = [ExerciseModel]()
    
    static func writeWorkout(exerciseName: String, numberOfReps: [Int], numberOfSets: [Int], sectionNumber: Int, alreadyAdded: Bool, dateCreated: String) {
        
        let updateWorkoutVar = ExerciseModel(exerciseName: exerciseName, numberOfReps: numberOfReps, numberOfSets: numberOfSets, sectionNumber: sectionNumber, alreadyAdded: alreadyAdded, dateCreated: dateCreated)
        let dict = updateWorkoutVar.dictValue
        
        let workoutRef = Database.database().reference().child("workout").child(User.current.uid).child(CalendarViewController.selectedDateVarString).child(currentSectionNumber)
        workoutRef.updateChildValues(dict)
        print("Selected date: \(CalendarViewController.selectedDateVarString)")
        
        let newWorkout = ExerciseModel(exerciseName: exerciseName, numberOfReps: numberOfReps, numberOfSets: numberOfSets, sectionNumber: sectionNumber, alreadyAdded: alreadyAdded, dateCreated: dateCreated)
        workoutArray.append(newWorkout)
        
    }
    
    static func updateWorkout(exerciseName: String, numberOfReps: [Int], numberOfSets: [Int], sectionNumber: Int, alreadyAdded: Bool, dateCreated: String){
        
        let workoutRef = Database.database().reference().child("workout").child(User.current.uid).child(CalendarViewController.selectedDateVarString).child(currentSectionNumber)
        workoutRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            workoutRef.child("exerciseName").setValue(exerciseName)
            workoutRef.child("numberOfReps").setValue(numberOfReps)
            workoutRef.child("numberOfSets").setValue(numberOfSets)
            workoutRef.child("sectionNumber").setValue(sectionNumber)
            workoutRef.child("alreadyAdded").setValue(alreadyAdded)
            workoutRef.child("dateCreated").setValue(dateCreated)
            
            
        })
    }
    
    
    static func pullAll() {
        
        let userMetricsRef = Database.database().reference().child("workout").child(User.current.uid).child(CalendarViewController.selectedDateVarString)
        userMetricsRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for item in snapshot.children {
                if let node = item as? DataSnapshot {
                    print(node.key) //Which node
                    let exerciseName = node.childSnapshot(forPath: "exerciseName").value
                    let numberOfReps = node.childSnapshot(forPath: "numberOfReps").value
                    let numberOfSets = node.childSnapshot(forPath: "numberOfSets").value
                    let sectionNumber = node.childSnapshot(forPath: "sectionNumber").value
                    let alreadyAdded = node.childSnapshot(forPath: "alreadyAdded").value
                    let dateCreated = node.childSnapshot(forPath: "dateCreated").value
                    print(exerciseName)
                    print(numberOfReps)
                    print(numberOfSets)
                    print(sectionNumber)
                    print(alreadyAdded)
                    print(dateCreated)
                    let pulledWorkout = ExerciseModel(exerciseName: exerciseName as! String, numberOfReps: numberOfReps as! [Int], numberOfSets: numberOfSets as! [Int], sectionNumber: sectionNumber as! Int, alreadyAdded: alreadyAdded as! Bool, dateCreated: dateCreated as! String)
                    self.workoutArray.append(pulledWorkout)
                }
            }
            
        })
    }
    
    
}
