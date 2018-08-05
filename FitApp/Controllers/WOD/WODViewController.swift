//
//  ViewController.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/23/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit

class WODViewController: UIViewController {
    
    //Objects
    @IBOutlet weak var newExerciseButton: UIButton!
    @IBOutlet weak var exerciseListTableView: UITableView!
    @IBOutlet var addTimeStepper: UIStepper!
    
    //Exercise Properties
    var selectedExercise = ExerciseModel(exerciseName: "", numberOfReps: [1], numberOfSets: [1], weight: [0], completed: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: "", restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.foundational.rawValue)
    
    //List of Exercises
    let listOfExercisesReference = ListOfExercises()
    var listOfExercises = [ExerciseModel]()
    
    //Timer
    @IBOutlet weak var toggleTimerButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var timerProgressView: UIProgressView!
    var timerLength = 60
    var savedTime = 60
    var timerIsRunning = false
    var countDownTimer = Timer()
    
    //Calendar
    var previousDate = ""
    @IBOutlet weak var dateLabel: UILabel!
    
    
    //Table View
    static var copiedVariable = [ExerciseModel]()
    
    //Animation
    @IBOutlet weak var restView: UIView!
    
    
    //Overide Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        listOfExercises = listOfExercisesReference.listOfExercises
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(tap)
        
        
        previousDate = Date().toString(dateFormat: "MMM-dd-yyyy")
        
        timerLabel.text = String(timerLength)
        timerProgressView.progress = Float(timerLength/savedTime)
        timerProgressView.barHeight = self.view.frame.height*0.005
        
        
        configureTableView()
        
        restView.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            var exerciseArray: IndexSet = []
            for exercise in WorkoutService.workoutArray{
                
                
                if CalendarViewController.selectedDateVarString == exercise.dateCreated {
                    
                    exerciseArray.insert(exercise.sectionNumber)
                }
            }
            
            
            self.exerciseListTableView.insertSections(exerciseArray, with: .fade)
            WODViewController.copyOverData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        exerciseListTableView.reloadData()
        
        for exercise in WorkoutService.workoutArray{
            
            
            
            if previousDate != CalendarViewController.selectedDateVarString{
                
                var exerciseArray: IndexSet = []
                
                if exerciseListTableView.numberOfSections != 0 {
                    
                    for section in 0...exerciseListTableView.numberOfSections-1 {
                        exerciseArray.insert(section)
                    }
                    WorkoutService.workoutArray = []
                    exerciseListTableView.deleteSections(exerciseArray, with: .none)
                    
                    
                }
                
                previousDate = CalendarViewController.selectedDateVarString
                
                if CalendarViewController.selectedDateVarString == exercise.dateCreated {
                    
                    var exerciseArray: IndexSet = []
                    
                    for exercise in WorkoutService.workoutArray{
                        
                        if CalendarViewController.selectedDateVarString == exercise.dateCreated {
                            exerciseArray.insert(exercise.sectionNumber)
                        }
                        
                        
                        self.exerciseListTableView.insertSections(exerciseArray, with: .fade)
                        
                    }
                }
                WODViewController.copyOverData()
                exerciseListTableView.reloadData()
            }
            
            
        }
        dateLabel.text = CalendarViewController.selectedDateVarString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IB Actions
    @IBAction func newExerciseTapped(_ sender: Any) {
        
    }
    
    @IBAction func unwindWithSegueToHome(_ segue: UIStoryboardSegue){
        
    }
    
    
    //Setting Table View
    
    func formatTableView(){
        //No sections on loading
        
        selectedExercise.sectionNumber = Int(WorkoutService.currentSectionNumber)!
        selectedExercise.alreadyAdded = true
        saveWorkout()
    }
    
    func configureTableView() {
        
        //remove separators for empty cells
        exerciseListTableView.tableFooterView = UIView()
        //remove separators from cells
        exerciseListTableView.separatorStyle = .none
        //remove scroll
        exerciseListTableView.showsVerticalScrollIndicator = false
        
    }
    
    //Stopwatch
    @IBAction func toggleTimerTapped(_ sender: Any) {
        
        if timerIsRunning == false{
            
            countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WODViewController.timerControl), userInfo: nil, repeats: true)
            timerIsRunning = true
        } else {
            countDownTimer.invalidate()
            timerIsRunning = false
        }
        
    }
    
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        timerLength = savedTime
        timerLabel.text = String(timerLength)
        timerProgressView.progress = Float(timerLength/savedTime)
        
    }
    
    @objc func timerControl () {
        
        if timerLength > 0{
            timerLength -= 1
            timerLabel.text = String(timerLength)
            timerProgressView.progress = Float(Double(timerLength)/Double(savedTime))
        }
    }
    
    //Timer Actions
    @IBAction func stepperClicked(_ sender: Any) {
        
        if (sender as AnyObject).value > Double(timerLength) {
            increaseValue()
        } else {
            if savedTime > 10{
                decreaseValue()
            }
        }
    }
    
    func increaseValue(){
        savedTime += 10
        timerLength = savedTime
        timerLabel.text = String(timerLength)
        timerProgressView.progress = Float(timerLength/savedTime)
    }
    
    func decreaseValue(){
        savedTime -= 10
        timerLength = savedTime
        timerLabel.text = String(timerLength)
        timerProgressView.progress = Float(timerLength/savedTime)
    }
    
    //Saving Workout
    func saveWorkout(){
        
        if WorkoutService.workoutArray.count != 0 {
            
            
            var counter = 0
            
            for workout in WorkoutService.workoutArray {
                
                //Update existing exercise
                if CalendarViewController.selectedDateVarString == workout.dateCreated && selectedExercise.exerciseName == workout.exerciseName{
                    
                    
                    WorkoutService.currentSectionNumber = String(workout.sectionNumber)
                    
                    WorkoutService.updateWorkout(exerciseName: workout.exerciseName, numberOfReps: workout.numberOfReps, numberOfSets: workout.numberOfSets, weight: workout.weight, completed: workout.completed, sectionNumber: workout.sectionNumber, alreadyAdded: workout.alreadyAdded, dateCreated: CalendarViewController.selectedDateVarString, bodyPart: selectedExercise.bodyPart, restDays: selectedExercise.restDays, intensity: selectedExercise.intensity, workoutType: selectedExercise.intensity)
                    
                    selectedExercise.alreadyAdded = false
                    WODViewController.copyOverData()
                    
                    return
                    
                } else {
                    
                    //Writing new exercise
                    var isAlreadyAdded = false
                    if CalendarViewController.selectedDateVarString == workout.dateCreated && selectedExercise.exerciseName == workout.exerciseName{
                        isAlreadyAdded = true
                    }
                    counter += 1
                    
                    if isAlreadyAdded == false && counter == WorkoutService.workoutArray.count{
                        
                        
                        WorkoutService.currentSectionNumber = String(exerciseListTableView.numberOfSections)
                        
                        WorkoutService.writeWorkout(exerciseName: selectedExercise.exerciseName, numberOfReps: selectedExercise.numberOfReps, numberOfSets: selectedExercise.numberOfSets, weight: selectedExercise.weight, completed: selectedExercise.completed,sectionNumber: Int(WorkoutService.currentSectionNumber)!, alreadyAdded: selectedExercise.alreadyAdded, dateCreated: CalendarViewController.selectedDateVarString, bodyPart: selectedExercise.bodyPart, restDays: selectedExercise.restDays, intensity: selectedExercise.intensity, workoutType: selectedExercise.workoutType)
                        
                        selectedExercise.alreadyAdded = false
                        
                        exerciseListTableView.insertSections([Int(WorkoutService.currentSectionNumber)!], with: .fade)
                        
                        WODViewController.copyOverData()
                        
                        return
                    }
                }
            }
            
        } else {
            
            
            WorkoutService.writeWorkout(exerciseName: selectedExercise.exerciseName, numberOfReps: selectedExercise.numberOfReps, numberOfSets: selectedExercise.numberOfSets, weight: selectedExercise.weight, completed: selectedExercise.completed,sectionNumber: selectedExercise.sectionNumber, alreadyAdded: selectedExercise.alreadyAdded, dateCreated: CalendarViewController.selectedDateVarString, bodyPart: selectedExercise.bodyPart, restDays: selectedExercise.restDays, intensity: selectedExercise.intensity, workoutType: selectedExercise.workoutType)
            
            selectedExercise.alreadyAdded = false
            
            WODViewController.copyOverData()
            
            
        }
        
        //        exerciseListTableView.reloadData()
        
        
    }
    
    static func copyOverData(){
        
        if WorkoutService.workoutArray.count != 0{
            WODViewController.copiedVariable = []
            for x in WorkoutService.workoutArray{
                WODViewController.copiedVariable.append(x)
            }
        }
        if WorkoutService.workoutArray.count == 0{
            for x in WODViewController.copiedVariable{
                WorkoutService.workoutArray.append(x)
            }
        }
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}

//TableViews
extension WODViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var returnedValue = 0
        
        if WorkoutService.workoutArray.count != 0{
            for workout in WorkoutService.workoutArray {
                if CalendarViewController.selectedDateVarString == workout.dateCreated{
                    returnedValue += 1
                }
            }
        } else {
            returnedValue = 0
        }
        
        return returnedValue
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var valuedReturned = ""
        
        for exercise in WorkoutService.workoutArray {
            if exercise.sectionNumber == section && CalendarViewController.selectedDateVarString == exercise.dateCreated{
                valuedReturned = exercise.exerciseName
            }
        }
        
        return valuedReturned
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnedValue = 0
        if WorkoutService.workoutArray.count != 0{
            for exercise in WorkoutService.workoutArray {
                if exercise.sectionNumber == section && CalendarViewController.selectedDateVarString == exercise.dateCreated{
                    returnedValue = 3 + exercise.numberOfSets[0]
                }
            }
        } else {
            returnedValue = 0
        }
        
        return returnedValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var returnedValue = tableView.dequeueReusableCell(withIdentifier: "ExerciseHeaderCell", for: indexPath)
        
        if WorkoutService.workoutArray.count != 0 {
            for exercise in WorkoutService.workoutArray {
                if exercise.dateCreated == CalendarViewController.selectedDateVarString && exercise.sectionNumber == indexPath.section {
                    switch  indexPath.row {
                    case 0:
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseHeaderCell", for: indexPath) as! ExerciseHeaderCell
                        cell.delegate = self as ExerciseHeaderCellDelegate
                        returnedValue = cell
                    case 1:
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseLabelsCell", for: indexPath) as! ExerciseLabelsCell
                        returnedValue = cell
                    // + 2 because middle = 2 + numberOfSets
                    case let x where x > 1 && x < exercise.numberOfSets[0] + 2 :
                        let cell = tableView.dequeueReusableCell(withIdentifier: "SetDataCell", for: indexPath) as! SetDataCell
                        cell.delegate = self as SetDataCellDelegate
                        cell.setNumberLabel.text = "Set # \(indexPath.row-1)"
                        cell.numberOfRepsTextField.text = String(exercise.numberOfReps[indexPath.row-2])
                        cell.weightTextField.text = String(exercise.weight[indexPath.row-2])
                        cell.checkBox.borderStyle = .circle
                        cell.checkBox.checkmarkStyle = .tick
                        cell.checkBox.checkmarkColor = .blue
                        cell.checkBox.checkedBorderColor = .blue
                        cell.checkBox.uncheckedBorderColor = .black
                        if exercise.completed[indexPath.row-2] == 1{
                            cell.checkBox.isChecked = true
                        } else {
                            cell.checkBox.isChecked = false
                        }
                        cell.checkBox.addTarget(cell, action: #selector(cell.checkboxValueChanged(sender:)), for: .valueChanged)
                        returnedValue = cell
                    case exercise.numberOfSets[0]+2:
                        let cell = tableView.dequeueReusableCell(withIdentifier: "AddingSetCell", for: indexPath) as! AddingSetCell
                        cell.delegate = self as AddingSetCellDelegate
                        returnedValue = cell
                    default:
                        fatalError("Error unexpected Indexpath.row \(indexPath.row)")
                    }
                }
            }
        }
        
        
        return returnedValue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedExercise = WorkoutService.workoutArray[indexPath.section]
    }
    
    
    
}

//Set Cell
extension WODViewController: SetDataCellDelegate{
    
    func savingWeight(cell: SetDataCell, weight: Int) {
        
        let indexPath = exerciseListTableView.indexPath(for: cell)!
        
        for exercise in WorkoutService.workoutArray{
            if indexPath.section == exercise.sectionNumber && CalendarViewController.selectedDateVarString == exercise.dateCreated{
                
                selectedExercise = exercise
                selectedExercise.weight[indexPath.row-2] = weight
                
                
                saveWorkout()
                
                
            }
        }
        
    }
    
    func reloadingNumberOfReps(cell: SetDataCell, numberOfReps: Int) {
        
        let indexPath = exerciseListTableView.indexPath(for: cell)!
        
        for exercise in WorkoutService.workoutArray{
            if indexPath.section == exercise.sectionNumber && CalendarViewController.selectedDateVarString == exercise.dateCreated{
                
                selectedExercise = exercise
                selectedExercise.numberOfReps[indexPath.row-2] = numberOfReps
                
                
                saveWorkout()
                
                
            }
        }
    }
    
    func setCompleted(cell: SetDataCell, checked: Bool){
        
        let indexPath = exerciseListTableView.indexPath(for: cell)!
        
        for exercise in WorkoutService.workoutArray{
            if indexPath.section == exercise.sectionNumber && CalendarViewController.selectedDateVarString == exercise.dateCreated{
                
                selectedExercise = exercise
                
                if checked == true{
                    selectedExercise.completed[indexPath.row-2] = 1
                } else {
                    selectedExercise.completed[indexPath.row-2] = 0
                }
                
                
                saveWorkout()
                
                
            }
        }
        
        if checked == true {
            
            if timerIsRunning == false{
                
                countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WODViewController.timerControl), userInfo: nil, repeats: true)
                timerIsRunning = true
            } else {
                countDownTimer.invalidate()
                timerLength = savedTime
                timerLabel.text = String(timerLength)
                timerProgressView.progress = Float(timerLength/savedTime)
                countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WODViewController.timerControl), userInfo: nil, repeats: true)
                timerIsRunning = true
            }
            
            restView.isHidden = false
            restView.alpha = 0.0
            restView.fadeIn()
            restView.fadeOut()
        }
        
        
        
        
    }
    
    func deleteRow(cell: SetDataCell){
        
        let indexPath = exerciseListTableView.indexPath(for: cell)!
        
        for exercise in WorkoutService.workoutArray{
            if indexPath.section == exercise.sectionNumber && CalendarViewController.selectedDateVarString == exercise.dateCreated{
                if indexPath.row != 0 || indexPath.row != 1 || indexPath.row != exercise.numberOfSets[0]+2{
                    if exercise.numberOfSets[0] > 1{
                        selectedExercise = exercise
                        exercise.numberOfSets[0] -= 1
                        exercise.numberOfReps.remove(at: indexPath.row-2)
                        exercise.weight.remove(at: indexPath.row-2)
                        exercise.completed.remove(at: indexPath.row-2)
                        
                        
                        exerciseListTableView.deleteRows(at: [IndexPath(row: indexPath.row, section: exercise.sectionNumber)], with: .fade)
                        
                        saveWorkout()
                        
                        exerciseListTableView.reloadData()
                    }
                }
                
            }
        }
        
    }
    
}

//Adding Rep
extension WODViewController: AddingSetCellDelegate{
    
    func reloadingNumberOfSets(cell: AddingSetCell) {
        
        let indexPath = exerciseListTableView.indexPath(for: cell)!
        
        for exercise in WorkoutService.workoutArray{
            if indexPath.section == exercise.sectionNumber && CalendarViewController.selectedDateVarString == exercise.dateCreated{
                selectedExercise = exercise
                exercise.numberOfSets[0] += 1
                exercise.numberOfReps.append(1)
                exercise.weight.append(0)
                exercise.completed.append(0)
                
                
                exerciseListTableView.insertRows(at: [IndexPath(row: exercise.numberOfSets[0]+1, section: exercise.sectionNumber)], with: .fade)
                
                saveWorkout()
                
                
            }
        }
    }
    
}

//Deleting Exercise
extension WODViewController: ExerciseHeaderCellDelegate{
    
    func deleteExercise(cell: ExerciseHeaderCell) {
        
        var storedArray = [ExerciseModel]()
        
        let indexPath = exerciseListTableView.indexPath(for: cell)!
        
        WorkoutService.deleteSectionSender = "WOD"
        
        WorkoutService.currentSectionNumber = String(indexPath.section)
        
        
        for exercise in WorkoutService.workoutArray{
            
            
            
            if indexPath.section == exercise.sectionNumber && CalendarViewController.selectedDateVarString == exercise.dateCreated{
                
                
                WorkoutService.workoutArray.remove(at: WorkoutService.workoutArray.index(where: {$0 === exercise})!)
                WODViewController.copiedVariable.remove(at: WODViewController.copiedVariable.index(where: {$0 === exercise})!)

                //                exerciseListTableView.deleteSections([indexPath.section], with: .fade) //Messing with firebase
                WorkoutService.removeWorkout(exerciseName: exercise.exerciseName, numberOfReps: exercise.numberOfReps, numberOfSets: exercise.numberOfSets, weight: exercise.weight, completed: exercise.completed, sectionNumber: exercise.sectionNumber, alreadyAdded: exercise.alreadyAdded, dateCreated: exercise.dateCreated, bodyPart: exercise.bodyPart, restDays: exercise.restDays, intensity: exercise.intensity, workoutType: exercise.workoutType)
                WODViewController.copyOverData()
            }
            
            if exercise.dateCreated == CalendarViewController.selectedDateVarString && exercise.sectionNumber != indexPath.section{
                storedArray.append(exercise)
            }
            
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            
            
            WorkoutService.workoutArray = []
            
            for exercise in storedArray{
                
                
                WorkoutService.currentSectionNumber = String(exercise.sectionNumber)
                
                WorkoutService.removeWorkout(exerciseName: exercise.exerciseName, numberOfReps: exercise.numberOfReps, numberOfSets: exercise.numberOfSets, weight: exercise.weight, completed: exercise.completed, sectionNumber: exercise.sectionNumber, alreadyAdded: exercise.alreadyAdded, dateCreated: exercise.dateCreated, bodyPart: exercise.bodyPart, restDays: exercise.restDays, intensity: exercise.intensity, workoutType: exercise.workoutType)
            }
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            var sectionCounter = 0
            
            for exercise in storedArray{
                
                WorkoutService.currentSectionNumber = String(sectionCounter)
                
                WorkoutService.writeWorkout(exerciseName: exercise.exerciseName, numberOfReps: exercise.numberOfReps, numberOfSets: exercise.numberOfSets, weight: exercise.weight, completed: exercise.completed, sectionNumber: Int(WorkoutService.currentSectionNumber)!, alreadyAdded: exercise.alreadyAdded, dateCreated: exercise.dateCreated, bodyPart: exercise.bodyPart, restDays: exercise.restDays, intensity: exercise.intensity, workoutType: exercise.workoutType)
                
                sectionCounter += 1
                
            }
            WODViewController.copyOverData()
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.exerciseListTableView.reloadData()}
    }
}










