//
//  ListOfExercises.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/23/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import Foundation

class ListOfExercises {
    

    var listOfExercises = [ExerciseModel]()
    static var listOfExeciseTypes = ["Chest", "Back", "Biceps", "Triceps", "Delts", "Abs", "Quads", "Hamstrings", "Calves", "Cardio", "Olympic Lifts"]

    
    //Chest
    //Horizontal Push
    var pushUp = ExerciseModel(exerciseName: "Push Up", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.chest.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var benchPress = ExerciseModel(exerciseName: "Bench Press", numberOfReps: [1], numberOfSets: [1],  weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.chest.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var declineBenchPress = ExerciseModel(exerciseName: "Decline Bench Press", numberOfReps: [1], numberOfSets: [1],  weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.chest.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    //Incline Push
    var inclinePress = ExerciseModel(exerciseName: "Incline Press", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.chest.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    //Chest Isolation
    var pecFlye = ExerciseModel(exerciseName: "Pec Flye", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.chest.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    
    
    
    //Back
    //Horizontal Pulling
    var bentOverRow = ExerciseModel(exerciseName: "Bent Over Row", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.back.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var cableRow = ExerciseModel(exerciseName: "Bent Over Row", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.back.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    //Vertical Pulling
    var pullUp = ExerciseModel(exerciseName: "Pull Up", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.back.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var pullDown = ExerciseModel(exerciseName: "Pull Down", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.back.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    
    
    
    //Biceps
    var bicepCurl = ExerciseModel(exerciseName: "Bicep Curl", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.bicep.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var hammerCurl = ExerciseModel(exerciseName: "Hammer Curl", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.bicep.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var cableCurl = ExerciseModel(exerciseName: "Cable Curl", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.bicep.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    
    
    
    //Triceps
    var dip = ExerciseModel(exerciseName: "Dip", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.tricep.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var tricepExtension = ExerciseModel(exerciseName: "Tricep Extension", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.tricep.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var tricepPushdown = ExerciseModel(exerciseName: "Tricep Pushdown", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.tricep.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var skullCrusher = ExerciseModel(exerciseName: "Skull Crusher", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.tricep.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    
    
    
    //Delts
    //Rear Delts
    var facePull = ExerciseModel(exerciseName: "Face Pull", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.delt.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var lateralRaise = ExerciseModel(exerciseName: "Lateral Raise", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.delt.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    //Side Delts
    var uprightRow = ExerciseModel(exerciseName: "Upright Row", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.delt.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    //Front Delts
    var shoulderPress = ExerciseModel(exerciseName: "Shoulder Press", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.delt.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var arnoldPress = ExerciseModel(exerciseName: "Arnold Press", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.delt.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    
    
    
    //Abs
    var crunch = ExerciseModel(exerciseName: "Crunch", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.abs.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var sitUp = ExerciseModel(exerciseName: "Sit Up", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.abs.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var vUp = ExerciseModel(exerciseName: "V Up", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.abs.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var legRaise = ExerciseModel(exerciseName: "Leg Raise", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.abs.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var abRoller = ExerciseModel(exerciseName: "Ab Roller", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.abs.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var bicycleCrunch = ExerciseModel(exerciseName: "Bicycle Crunch", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.abs.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    
    
    
    //Quads
    var airSquat = ExerciseModel(exerciseName: "Air Squat", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.quads.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var frontSquat = ExerciseModel(exerciseName: "Front Squat", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.quads.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var backSquat = ExerciseModel(exerciseName: "Back Squat", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.quads.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var legPress = ExerciseModel(exerciseName: "Leg Press", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.quads.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var bulgarianSplitSquat = ExerciseModel(exerciseName: "Leg Press", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.quads.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    
    
    
    
    //Hamstrings
    var deadLift = ExerciseModel(exerciseName: "Dead Lift", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.hamstrings.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var romanianDeadLift = ExerciseModel(exerciseName: "Romanian Dead Lift", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.hamstrings.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var oneLeggedDeadLift = ExerciseModel(exerciseName: "One Legged Dead Lift", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.hamstrings.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var legCurl = ExerciseModel(exerciseName: "Leg Curl", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.hamstrings.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    
    
    
    //Calves
    var calfRaises = ExerciseModel(exerciseName: "Calf Raises", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.calves.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var farmersWalk = ExerciseModel(exerciseName: "Farmers Walk", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.calves.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var dumbbellJumpSquat = ExerciseModel(exerciseName: "Dumbbell Jump Squat", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.calves.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    
    //Cardio
    var running = ExerciseModel(exerciseName: "Running", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.cardio.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.cardio.rawValue)
    var jumpingJacks = ExerciseModel(exerciseName: "Jumping Jacks", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.cardio.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.cardio.rawValue)
    var rowing = ExerciseModel(exerciseName: "Rowing", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.cardio.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.cardio.rawValue)
    var cycling = ExerciseModel(exerciseName: "Cycling", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.cardio.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.cardio.rawValue)
    var boxJump = ExerciseModel(exerciseName: "Rowing", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.cardio.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.cardio.rawValue)
    var burpies = ExerciseModel(exerciseName: "Burpies", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.cardio.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.cardio.rawValue)
    
    //Olympic Lifts
    var clean = ExerciseModel(exerciseName: "Clean", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.olympicLifts.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var cleanAndJerk = ExerciseModel(exerciseName: "Clean and Jerk", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.olympicLifts.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var powerSnatch = ExerciseModel(exerciseName: "Power Snatch", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.olympicLifts.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    var hangSnatch = ExerciseModel(exerciseName: "Hang Snatch", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0],sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.olympicLifts.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.strength.rawValue)
    
    init(){
        //Chest
        listOfExercises.append(pushUp)
        listOfExercises.append(benchPress)
        listOfExercises.append(inclinePress)
        listOfExercises.append(pecFlye)
        listOfExercises.append(declineBenchPress)
        
        //Back
        listOfExercises.append(bentOverRow)
        listOfExercises.append(cableRow)
        listOfExercises.append(pullUp)
        listOfExercises.append(pullDown)
        
        //Bicep
        listOfExercises.append(bicepCurl)
        listOfExercises.append(hammerCurl)
        listOfExercises.append(cableCurl)
        
        //Tricep
        listOfExercises.append(dip)
        listOfExercises.append(tricepExtension)
        listOfExercises.append(tricepPushdown)
        listOfExercises.append(skullCrusher)
        
        //Delt
        listOfExercises.append(facePull)
        listOfExercises.append(lateralRaise)
        listOfExercises.append(uprightRow)
        listOfExercises.append(shoulderPress)
        listOfExercises.append(arnoldPress)
        
        //Abs
        listOfExercises.append(crunch)
        listOfExercises.append(sitUp)
        listOfExercises.append(vUp)
        listOfExercises.append(legRaise)
        listOfExercises.append(abRoller)
        listOfExercises.append(bicycleCrunch)
        
        //Quads
        listOfExercises.append(airSquat)
        listOfExercises.append(frontSquat)
        listOfExercises.append(backSquat)
        listOfExercises.append(legPress)
        listOfExercises.append(bulgarianSplitSquat)
        
        //Hamsrings
        listOfExercises.append(deadLift)
        listOfExercises.append(romanianDeadLift)
        listOfExercises.append(oneLeggedDeadLift)
        listOfExercises.append(legCurl)
        
        //Calves
        listOfExercises.append(calfRaises)
        listOfExercises.append(farmersWalk)
        listOfExercises.append(dumbbellJumpSquat)
        
        //Cardio
        listOfExercises.append(running)
        listOfExercises.append(jumpingJacks)
        listOfExercises.append(rowing)
        listOfExercises.append(cycling)
        listOfExercises.append(boxJump)
        listOfExercises.append(burpies)
        
        //Olympic Lifts
        listOfExercises.append(clean)
        listOfExercises.append(cleanAndJerk)
        listOfExercises.append(powerSnatch)
        listOfExercises.append(hangSnatch)

    }
    
    
    
}
