//
//  WorkoutCalculator.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/30/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import Foundation

class WorkoutCalculator {
    
    static func createWorkoutProgram(weight: Int, height: Int, age: Int, gender: Int, date: String, goal: Int, bodyPart: Int, numberOfWeeks: Int){
        
    }
    
}

//Saving Workout
//func saveWorkout(){
//
//    if WorkoutService.workoutArray.count != 0 {
//
//        var counter = 0
//
//        for workout in WorkoutService.workoutArray {
//
//            //Update existing exercise
//            if CalendarViewController.selectedDateVarString == workout.dateCreated && selectedExercise.exerciseName == workout.exerciseName{
//
//
//                WorkoutService.currentSectionNumber = String(workout.sectionNumber)
//
//                WorkoutService.updateWorkout(exerciseName: workout.exerciseName, numberOfReps: workout.numberOfReps, numberOfSets: workout.numberOfSets, sectionNumber: workout.sectionNumber, alreadyAdded: workout.alreadyAdded, dateCreated: CalendarViewController.selectedDateVarString)
//
//                selectedExercise.alreadyAdded = false
//                copyOverData()
//
//                print("Date Exists")
//                return
//
//            } else {
//
//                //Writing new exercise
//                var isAlreadyAdded = false
//                if CalendarViewController.selectedDateVarString == workout.dateCreated && selectedExercise.exerciseName == workout.exerciseName{
//                    isAlreadyAdded = true
//                }
//                counter += 1
//                print("counting")
//                print(workout.exerciseName)
//                print(selectedExercise.exerciseName)
//                print(counter)
//                print(WorkoutService.workoutArray.count)
//                if isAlreadyAdded == false && counter == WorkoutService.workoutArray.count{
//                    print("Checking")
//                    print(CalendarViewController.selectedDateVarString)
//                    print(workout.dateCreated)
//                    print(selectedExercise.exerciseName)
//                    print(workout.exerciseName)
//
//                    WorkoutService.currentSectionNumber = String(exerciseListTableView.numberOfSections)
//
//                    WorkoutService.writeWorkout(exerciseName: selectedExercise.exerciseName, numberOfReps: selectedExercise.numberOfReps, numberOfSets: selectedExercise.numberOfSets, sectionNumber: Int(WorkoutService.currentSectionNumber)!, alreadyAdded: selectedExercise.alreadyAdded, dateCreated: CalendarViewController.selectedDateVarString)
//
//                    selectedExercise.alreadyAdded = false
//
//                    exerciseListTableView.insertSections([Int(WorkoutService.currentSectionNumber)!], with: .fade)
//
//                    copyOverData()
//
//                    print("Date Exists Not")
//                    return
//                }
//            }
//        }
//
//    } else {
//
//
//        WorkoutService.writeWorkout(exerciseName: selectedExercise.exerciseName, numberOfReps: selectedExercise.numberOfReps, numberOfSets: selectedExercise.numberOfSets, sectionNumber: selectedExercise.sectionNumber, alreadyAdded: selectedExercise.alreadyAdded, dateCreated: CalendarViewController.selectedDateVarString)
//
//        selectedExercise.alreadyAdded = false
//
//        copyOverData()
//
//        print("Empty")
//    }
//
//    exerciseListTableView.reloadData()
//    print("checking workout array")
//    print(WorkoutService.workoutArray)
//
//}
