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
    static var listOfDatesArray = [String]()
    
    static func writeWorkout(exerciseName: String, numberOfReps: [Int], numberOfSets: [Int], sectionNumber: Int, alreadyAdded: Bool, dateCreated: String, bodyPart: String, restDays: Int, intensity: String) {
        
        //Workout Firebase
        let updateWorkoutVar = ExerciseModel(exerciseName: exerciseName, numberOfReps: numberOfReps, numberOfSets: numberOfSets, sectionNumber: sectionNumber, alreadyAdded: alreadyAdded, dateCreated: dateCreated, bodyPart: bodyPart, restDays: restDays, intensity: intensity)
        let dict = updateWorkoutVar.dictValue
        
        let workoutRef = Database.database().reference().child("workout").child(User.current.uid).child(CalendarViewController.selectedDateVarString).child(currentSectionNumber)
        workoutRef.updateChildValues(dict)
        print("Selected date: \(CalendarViewController.selectedDateVarString)")
        
        let newWorkout = ExerciseModel(exerciseName: exerciseName, numberOfReps: numberOfReps, numberOfSets: numberOfSets, sectionNumber: sectionNumber, alreadyAdded: alreadyAdded, dateCreated: dateCreated, bodyPart: bodyPart, restDays: restDays, intensity: intensity)
        workoutArray.append(newWorkout)
        
        
        //Date Firebase
        let dateRef = Database.database().reference().child("listOfDates").child(User.current.uid).child(dateCreated)
        dateRef.updateChildValues(["date" : dateCreated])
        listOfDatesArray.append(dateCreated)
        
        
    }
    
    static func writeProgram(exerciseName: String, numberOfReps: [Int], numberOfSets: [Int], sectionNumber: Int, alreadyAdded: Bool, dateCreated: String, bodyPart: String, restDays: Int, intensity: String) {
        
        //Workout Firebase
        let updateWorkoutVar = ExerciseModel(exerciseName: exerciseName, numberOfReps: numberOfReps, numberOfSets: numberOfSets, sectionNumber: sectionNumber, alreadyAdded: alreadyAdded, dateCreated: dateCreated, bodyPart: bodyPart, restDays: restDays, intensity: intensity)
        let dict = updateWorkoutVar.dictValue
        
        let workoutRef = Database.database().reference().child("workout").child(User.current.uid).child(dateCreated).child(currentSectionNumber)
        workoutRef.updateChildValues(dict)
        print("Date Picker: \(UserMetricsViewController.datePicker.date.toString(dateFormat: "dd-MMM-yyyy"))")
        
        let newWorkout = ExerciseModel(exerciseName: exerciseName, numberOfReps: numberOfReps, numberOfSets: numberOfSets, sectionNumber: sectionNumber, alreadyAdded: alreadyAdded, dateCreated: dateCreated, bodyPart: bodyPart, restDays: restDays, intensity: intensity)
        workoutArray.append(newWorkout)
        
        
        //Date Firebase
        let dateRef = Database.database().reference().child("listOfDates").child(User.current.uid).child(dateCreated)
        dateRef.updateChildValues(["date" : dateCreated])
        listOfDatesArray.append(dateCreated)
        
        
    }
    
    
    
    static func updateWorkout(exerciseName: String, numberOfReps: [Int], numberOfSets: [Int], sectionNumber: Int, alreadyAdded: Bool, dateCreated: String, bodyPart: String, restDays: Int, intensity: String ){
        
        let workoutRef = Database.database().reference().child("workout").child(User.current.uid).child(CalendarViewController.selectedDateVarString).child(currentSectionNumber)
        workoutRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            workoutRef.child("exerciseName").setValue(exerciseName)
            workoutRef.child("numberOfReps").setValue(numberOfReps)
            workoutRef.child("numberOfSets").setValue(numberOfSets)
            workoutRef.child("sectionNumber").setValue(sectionNumber)
            workoutRef.child("alreadyAdded").setValue(alreadyAdded)
            workoutRef.child("dateCreated").setValue(dateCreated)
            workoutRef.child("bodyPart").setValue(bodyPart)
            workoutRef.child("restDays").setValue(restDays)
            workoutRef.child("intensity").setValue(intensity)
            
            
        })
    }
    
    
    static func pullAll() {
        
        let dateRef = Database.database().reference().child("listOfDates").child(User.current.uid)
        dateRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for item in snapshot.children {
                if let node = item as? DataSnapshot {
                    print(node.key) //Which node
                    let datePulled = node.childSnapshot(forPath: "date").value
                    self.listOfDatesArray.append(datePulled as! String)
                }
            }
            
            for date in listOfDatesArray{
                
                let userMetricsRef = Database.database().reference().child("workout").child(User.current.uid).child(date)
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
                            let bodyPart = node.childSnapshot(forPath: "bodyPart").value
                            let restDays = node.childSnapshot(forPath: "restDays").value
                            let intensity = node.childSnapshot(forPath: "intensity").value
                            print(exerciseName)
                            print(numberOfReps)
                            print(numberOfSets)
                            print(sectionNumber)
                            print(alreadyAdded)
                            print(dateCreated)
                            print(bodyPart)
                            print(restDays)
                            print(intensity)
                            let pulledWorkout = ExerciseModel(exerciseName: exerciseName as! String, numberOfReps: numberOfReps as! [Int], numberOfSets: numberOfSets as! [Int], sectionNumber: sectionNumber as! Int, alreadyAdded: alreadyAdded as! Bool, dateCreated: dateCreated as! String, bodyPart: bodyPart as! String, restDays: restDays as! Int, intensity: intensity as! String)
                            self.workoutArray.append(pulledWorkout)
                        }
                    }
                })
            }
        })
    }
    
    static func removeWorkout(exerciseName: String, numberOfReps: [Int], numberOfSets: [Int], sectionNumber: Int, alreadyAdded: Bool, dateCreated: String, bodyPart: String, restDays: Int, intensity: String) {
        
        //Workout Firebase
        let workoutRef = Database.database().reference().child("workout").child(User.current.uid).child(UserMetricsViewController.dateTracker.toString(dateFormat: "dd-MMM-yyyy")).child(currentSectionNumber)
        workoutRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            workoutRef.child("exerciseName").removeValue()
            workoutRef.child("numberOfReps").removeValue()
            workoutRef.child("numberOfSets").removeValue()
            workoutRef.child("sectionNumber").removeValue()
            workoutRef.child("alreadyAdded").removeValue()
            workoutRef.child("dateCreated").removeValue()
            workoutRef.child("bodyPart").removeValue()
            workoutRef.child("restDays").removeValue()
            workoutRef.child("intensity").removeValue()
            
            
        })
        
        for workout in WorkoutService.workoutArray{
            if workout.dateCreated == dateCreated {
                WorkoutService.workoutArray.remove(at: WorkoutService.workoutArray.index(where: {$0 === workout})!)
            }
        }
        
        
//        //Date Firebase
        let dateRef = Database.database().reference().child("listOfDates").child(User.current.uid).child(dateCreated)
        dateRef.observeSingleEvent(of: .value, with: { (snapshot) in

            dateRef.child("date").removeValue()
        })
        
    }
}
