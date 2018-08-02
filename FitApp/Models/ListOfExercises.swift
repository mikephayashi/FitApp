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

    
    //Chest
    //Horizontal Push
    var pushUp = ExerciseModel(exerciseName: "Push Up", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.chest.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    var benchPress = ExerciseModel(exerciseName: "Bench Press", numberOfReps: [1], numberOfSets: [1],  weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.chest.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    //Incline Push
    var inclinePress = ExerciseModel(exerciseName: "Incline Press", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.chest.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    //Chest Isolation
    var pecFlye = ExerciseModel(exerciseName: "Pec Flye", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.chest.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    
    
    
    //Back
    //Horizontal Pulling
    var bentOverRow = ExerciseModel(exerciseName: "Bent Over Row", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.back.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    //Vertical Pulling
    var pullUp = ExerciseModel(exerciseName: "Pull Up", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.back.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    var pullDown = ExerciseModel(exerciseName: "Pull Down", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.back.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    
    
    
    //Biceps
    var bicepCurl = ExerciseModel(exerciseName: "Bicep Curl", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.bicep.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    var hammerCurl = ExerciseModel(exerciseName: "Hammer Curl", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.bicep.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    
    
    
    //Triceps
    var skullCrusher = ExerciseModel(exerciseName: "Skull Crusher", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.tricep.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    var dip = ExerciseModel(exerciseName: "Dip", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.tricep.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    var tricepExtension = ExerciseModel(exerciseName: "Tricep Extension", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.tricep.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    
    
    
    //Delts
    //Rear Delts
    var facePull = ExerciseModel(exerciseName: "Face Pull", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.delt.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    var lateralRaise = ExerciseModel(exerciseName: "Lateral Raise", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.delt.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    //Side Delts
    var uprightRow = ExerciseModel(exerciseName: "Upright Row", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.delt.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    //Front Delts
    var shoulderPress = ExerciseModel(exerciseName: "Shoulder Press", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.delt.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    
    
    
    //Abs
    var sitUp = ExerciseModel(exerciseName: "Sit Up", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.abs.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    var vUp = ExerciseModel(exerciseName: "V Up", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.abs.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    var legRaise = ExerciseModel(exerciseName: "Leg Raise", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.abs.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    
    
    
    //Quads
    var backSquat = ExerciseModel(exerciseName: "Back Squat", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.quads.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    var frontSquat = ExerciseModel(exerciseName: "Front Squat", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.quads.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    var legPress = ExerciseModel(exerciseName: "Leg Press", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.quads.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    
    
    
    //Hamstrings
    var deadLift = ExerciseModel(exerciseName: "Dead Lift", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.hamstrings.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    var legCurl = ExerciseModel(exerciseName: "Leg Curl", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.hamstrings.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    
    
    
    //Calves
    var calfRaises = ExerciseModel(exerciseName: "Calf Raises", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: ExerciseModel.BodyPart.calves.rawValue, restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    
    
    init(){
        listOfExercises.append(pushUp)
        listOfExercises.append(benchPress)
        listOfExercises.append(inclinePress)
        listOfExercises.append(pecFlye)
        listOfExercises.append(bentOverRow)
        listOfExercises.append(pullUp)
        listOfExercises.append(pullDown)
        listOfExercises.append(bicepCurl)
        listOfExercises.append(hammerCurl)
        listOfExercises.append(skullCrusher)
        listOfExercises.append(dip)
        listOfExercises.append(tricepExtension)
        listOfExercises.append(facePull)
        listOfExercises.append(lateralRaise)
        listOfExercises.append(uprightRow)
        listOfExercises.append(shoulderPress)
        listOfExercises.append(sitUp)
        listOfExercises.append(vUp)
        listOfExercises.append(legRaise)
        listOfExercises.append(backSquat)
        listOfExercises.append(frontSquat)
        listOfExercises.append(legPress)
        listOfExercises.append(deadLift)
        listOfExercises.append(legCurl)
        listOfExercises.append(calfRaises)

    }
    
    
    
}
