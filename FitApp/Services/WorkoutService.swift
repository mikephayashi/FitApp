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
    static var deleteSectionSender = ""
    
    static func writeWorkout(exerciseName: String, numberOfReps: [Int], numberOfSets: [Int], weight: [Int], completed: [Int], sectionNumber: Int, alreadyAdded: Bool, dateCreated: String, bodyPart: String, restDays: Int, intensity: String, workoutType: String) {
        
        //Workout Firebase
        let updateWorkoutVar = ExerciseModel(exerciseName: exerciseName, numberOfReps: numberOfReps, numberOfSets: numberOfSets, weight: weight, completed: completed, sectionNumber: sectionNumber, alreadyAdded: alreadyAdded, dateCreated: dateCreated, bodyPart: bodyPart, restDays: restDays, intensity: intensity, workoutType: workoutType)
        let dict = updateWorkoutVar.dictValue
        
        let workoutRef = Database.database().reference().child("workout").child(User.current.uid).child(CalendarViewController.selectedDateVarString).child(currentSectionNumber)
        workoutRef.updateChildValues(dict)
        
        let newWorkout = ExerciseModel(exerciseName: exerciseName, numberOfReps: numberOfReps, numberOfSets: numberOfSets, weight: weight, completed: completed, sectionNumber: sectionNumber, alreadyAdded: alreadyAdded, dateCreated: dateCreated, bodyPart: bodyPart, restDays: restDays, intensity: intensity, workoutType: workoutType)
        workoutArray.append(newWorkout)
        
        
        //Date Firebase
        let dateRef = Database.database().reference().child("listOfDates").child(User.current.uid).child(dateCreated)
        dateRef.updateChildValues(["date" : dateCreated])
        listOfDatesArray.append(dateCreated)
        
        
    }
    
    static func writeProgram(exerciseName: String, numberOfReps: [Int], numberOfSets: [Int], weight: [Int], completed: [Int], sectionNumber: Int, alreadyAdded: Bool, dateCreated: String, bodyPart: String, restDays: Int, intensity: String, workoutType: String) {
        
        //Workout Firebase
        let updateWorkoutVar = ExerciseModel(exerciseName: exerciseName, numberOfReps: numberOfReps, numberOfSets: numberOfSets, weight: weight, completed: completed, sectionNumber: sectionNumber, alreadyAdded: alreadyAdded, dateCreated: dateCreated, bodyPart: bodyPart, restDays: restDays, intensity: intensity, workoutType: workoutType)
        let dict = updateWorkoutVar.dictValue
        
        let workoutRef = Database.database().reference().child("workout").child(User.current.uid).child(dateCreated).child(currentSectionNumber)
        workoutRef.updateChildValues(dict)
        
        
        let newWorkout = ExerciseModel(exerciseName: exerciseName, numberOfReps: numberOfReps, numberOfSets: numberOfSets, weight: weight, completed: completed, sectionNumber: sectionNumber, alreadyAdded: alreadyAdded, dateCreated: dateCreated, bodyPart: bodyPart, restDays: restDays, intensity: intensity, workoutType: workoutType)
        workoutArray.append(newWorkout)
        
        
        //Date Firebase
        let dateRef = Database.database().reference().child("listOfDates").child(User.current.uid).child(dateCreated)
        dateRef.updateChildValues(["date" : dateCreated])
        listOfDatesArray.append(dateCreated)
        
        
    }
    
    
    
    static func updateWorkout(exerciseName: String, numberOfReps: [Int], numberOfSets: [Int], weight: [Int], completed: [Int], sectionNumber: Int, alreadyAdded: Bool, dateCreated: String, bodyPart: String, restDays: Int, intensity: String, workoutType: String ){
        
        let workoutRef = Database.database().reference().child("workout").child(User.current.uid).child(CalendarViewController.selectedDateVarString).child(currentSectionNumber)
        workoutRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            workoutRef.child("exerciseName").setValue(exerciseName)
            workoutRef.child("numberOfReps").setValue(numberOfReps)
            workoutRef.child("numberOfSets").setValue(numberOfSets)
            workoutRef.child("weight").setValue(weight)
            workoutRef.child("completed").setValue(completed)
            workoutRef.child("sectionNumber").setValue(sectionNumber)
            workoutRef.child("alreadyAdded").setValue(alreadyAdded)
            workoutRef.child("dateCreated").setValue(dateCreated)
            workoutRef.child("bodyPart").setValue(bodyPart)
            workoutRef.child("restDays").setValue(restDays)
            workoutRef.child("intensity").setValue(intensity)
            workoutRef.child("workoutType").setValue(workoutType)
            
            
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
                            let weight = node.childSnapshot(forPath: "weight").value
                            let completed = node.childSnapshot(forPath: "completed").value
                            let sectionNumber = node.childSnapshot(forPath: "sectionNumber").value
                            let alreadyAdded = node.childSnapshot(forPath: "alreadyAdded").value
                            let dateCreated = node.childSnapshot(forPath: "dateCreated").value
                            let bodyPart = node.childSnapshot(forPath: "bodyPart").value
                            let restDays = node.childSnapshot(forPath: "restDays").value
                            let intensity = node.childSnapshot(forPath: "intensity").value
                            let workoutType = node.childSnapshot(forPath: "workoutType").value

                            let pulledWorkout = ExerciseModel(exerciseName: exerciseName as! String, numberOfReps: numberOfReps as! [Int], numberOfSets: numberOfSets as! [Int], weight: weight as! [Int], completed: completed as! [Int], sectionNumber: sectionNumber as! Int, alreadyAdded: alreadyAdded as! Bool, dateCreated: dateCreated as! String, bodyPart: bodyPart as! String, restDays: restDays as! Int, intensity: intensity as! String, workoutType: workoutType as! String)
                            self.workoutArray.append(pulledWorkout)
                        }
                    }
                })
            }
        })
    }
    
    static func removeWorkout(exerciseName: String, numberOfReps: [Int], numberOfSets: [Int], weight: [Int], completed: [Int], sectionNumber: Int, alreadyAdded: Bool, dateCreated: String, bodyPart: String, restDays: Int, intensity: String, workoutType: String) {
        
        //Workout Firebase
        
        var workoutRef = Database.database().reference().child("workout").child(User.current.uid).child(UserMetricsViewController.dateTracker.toString(dateFormat: "dd-MMM-yyyy")).child(currentSectionNumber)
        if WorkoutService.deleteSectionSender == "UserMetrics"{
        workoutRef = Database.database().reference().child("workout").child(User.current.uid).child(UserMetricsViewController.dateTracker.toString(dateFormat: "dd-MMM-yyyy")).child(currentSectionNumber)
        } else if WorkoutService.deleteSectionSender == "WOD"{
            workoutRef = Database.database().reference().child("workout").child(User.current.uid).child(CalendarViewController.selectedDateVarString).child(currentSectionNumber)
        }
        
        workoutRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            workoutRef.child("exerciseName").removeValue()
            workoutRef.child("numberOfReps").removeValue()
            workoutRef.child("numberOfSets").removeValue()
            workoutRef.child("weight").removeValue()
            workoutRef.child("completed").removeValue()
            workoutRef.child("sectionNumber").removeValue()
            workoutRef.child("alreadyAdded").removeValue()
            workoutRef.child("dateCreated").removeValue()
            workoutRef.child("bodyPart").removeValue()
            workoutRef.child("restDays").removeValue()
            workoutRef.child("intensity").removeValue()
            workoutRef.child("workoutType").removeValue()
            
            
        })
        
        if WorkoutService.deleteSectionSender == "UserMetrics"{
            for workout in WorkoutService.workoutArray{
                if workout.dateCreated == dateCreated {
                    WorkoutService.workoutArray.remove(at: WorkoutService.workoutArray.index(where: {$0 === workout})!)
                }
            }
        } else if WorkoutService.deleteSectionSender == "WOD"{
            for workout in WorkoutService.workoutArray{
                if workout.dateCreated == dateCreated && workout.sectionNumber == sectionNumber{
                    WorkoutService.workoutArray.remove(at: WorkoutService.workoutArray.index(where: {$0 === workout})!)
                }
            }
        }
        
        if WorkoutService.deleteSectionSender == "UserMetrics"{
            //Date Firebase
            let dateRef = Database.database().reference().child("listOfDates").child(User.current.uid).child(dateCreated)
            dateRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                dateRef.child("date").removeValue()
            })
        }
        
    }
}
