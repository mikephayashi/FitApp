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
    var selectedExercise = ExerciseModel(exerciseName: "", numberOfReps: [1], numberOfSets: [1], sectionNumber: 0, alreadyAdded: false, dateCreated: "")
    
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
    
    //Table View
    var copiedVariable = [ExerciseModel]()
    
    //Overide Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        listOfExercises = listOfExercisesReference.listOfExercises
        
        
        previousDate = Date().toString(dateFormat: "dd-MMM-yyyy")
        
        timerLabel.text = String(timerLength)
        timerProgressView.progress = Float(timerLength/savedTime)
        timerProgressView.barHeight = self.view.frame.height*0.005
        
        configureTableView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            var exerciseArray: IndexSet = []
            for exercise in WorkoutService.workoutArray{
                print("adding")
                
                if CalendarViewController.selectedDateVarString == exercise.dateCreated {
                    print("actually added")
                    exerciseArray.insert(exercise.sectionNumber)
                }
            }
            
            print(exerciseArray)
            self.exerciseListTableView.insertSections(exerciseArray, with: .fade)
            self.copyOverData()
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Appear")
        print(WorkoutService.workoutArray)
        print(copiedVariable)
        exerciseListTableView.reloadData()
        
        for exercise in WorkoutService.workoutArray{
            
            print("stuff here")
            
            print(previousDate)
            print(CalendarViewController.selectedDateVarString)
            
            if previousDate != CalendarViewController.selectedDateVarString{
                print("loading data")
                print(WorkoutService.workoutArray)
                print(copiedVariable)
                var exerciseArray: IndexSet = []
                var numberOfSections = exerciseListTableView.numberOfSections
                
                if exerciseListTableView.numberOfSections != 0 {
                    print("deleting stuff")
                    for section in 0...exerciseListTableView.numberOfSections-1 {
                        exerciseArray.insert(section)
                    }
                    WorkoutService.workoutArray = []
                    exerciseListTableView.deleteSections(exerciseArray, with: .none)
                    copyOverData()
                    print(copiedVariable)
                    print(WorkoutService.workoutArray)
                }
                
                previousDate = CalendarViewController.selectedDateVarString
                
                if CalendarViewController.selectedDateVarString == exercise.dateCreated {
                    print("checking")
                    var exerciseArray: IndexSet = []
                    
                    for exercise in WorkoutService.workoutArray{
                        print("stuff here")
                        if CalendarViewController.selectedDateVarString == exercise.dateCreated {
                            print("adding")
                            print(exerciseArray)
                            exerciseArray.insert(exercise.sectionNumber)
                            print(exerciseArray)
                            print(exercise.sectionNumber)
                            print(exercise.exerciseName)
                            print(CalendarViewController.selectedDateVarString)
                            print(exercise.dateCreated)
                        }
                        
                    }
                    print("insert section")
                    print(exerciseArray)
                    self.exerciseListTableView.insertSections(exerciseArray, with: .fade)
                    
                }
            }
            
            exerciseListTableView.reloadData()
        }
        
        
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
        print("formatting table view")
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
            decreaseValue()
        }
    }
    
    func increaseValue(){
        savedTime += 10
        timerLength = savedTime
        timerLabel.text = String(timerLength)
        timerProgressView.progress = Float(timerLength/60)
    }
    
    func decreaseValue(){
        savedTime -= 10
        timerLength = savedTime
        timerLabel.text = String(timerLength)
        timerProgressView.progress = Float(timerLength/60)
    }
    
    //Saving Workout
    func saveWorkout(){
        
        if WorkoutService.workoutArray.count != 0 {
            
            print("Saving Workout")
            print(WorkoutService.workoutArray.count)
            print(WorkoutService.workoutArray)
            print(selectedExercise.exerciseName)
            
            var counter = 0
            
            for workout in WorkoutService.workoutArray {
                
                //Update existing exercise
                if CalendarViewController.selectedDateVarString == workout.dateCreated && selectedExercise.exerciseName == workout.exerciseName{
                    
                    
                    WorkoutService.currentSectionNumber = String(workout.sectionNumber)
                    
                    WorkoutService.updateWorkout(exerciseName: workout.exerciseName, numberOfReps: workout.numberOfReps, numberOfSets: workout.numberOfSets, sectionNumber: workout.sectionNumber, alreadyAdded: workout.alreadyAdded, dateCreated: CalendarViewController.selectedDateVarString)
                    
                    selectedExercise.alreadyAdded = false
                    copyOverData()
                    
                    print("Date Exists")
                    return
                    
                } else {
                    
                    //Writing new exercise
                    var isAlreadyAdded = false
                    if CalendarViewController.selectedDateVarString == workout.dateCreated && selectedExercise.exerciseName == workout.exerciseName{
                        isAlreadyAdded = true
                    }
                    counter += 1
                    print("counting")
                    print(workout.exerciseName)
                    print(selectedExercise.exerciseName)
                    print(counter)
                    print(WorkoutService.workoutArray.count)
                    if isAlreadyAdded == false && counter == WorkoutService.workoutArray.count{
                        print("Checking")
                        print(CalendarViewController.selectedDateVarString)
                        print(workout.dateCreated)
                        print(selectedExercise.exerciseName)
                        print(workout.exerciseName)
                        
                        WorkoutService.currentSectionNumber = String(exerciseListTableView.numberOfSections)
                        
                        WorkoutService.writeWorkout(exerciseName: selectedExercise.exerciseName, numberOfReps: selectedExercise.numberOfReps, numberOfSets: selectedExercise.numberOfSets, sectionNumber: Int(WorkoutService.currentSectionNumber)!, alreadyAdded: selectedExercise.alreadyAdded, dateCreated: CalendarViewController.selectedDateVarString)
                        
                        selectedExercise.alreadyAdded = false
                        
                        exerciseListTableView.insertSections([Int(WorkoutService.currentSectionNumber)!], with: .fade)
                        
                        copyOverData()
                        
                        print("Date Exists Not")
                        return
                    }
                }
            }
            
        } else {
            
            
            WorkoutService.writeWorkout(exerciseName: selectedExercise.exerciseName, numberOfReps: selectedExercise.numberOfReps, numberOfSets: selectedExercise.numberOfSets, sectionNumber: selectedExercise.sectionNumber, alreadyAdded: selectedExercise.alreadyAdded, dateCreated: CalendarViewController.selectedDateVarString)
            
            selectedExercise.alreadyAdded = false
            
            copyOverData()
            
            print("Empty")
        }
        
        exerciseListTableView.reloadData()
        print("checking workout array")
        print(WorkoutService.workoutArray)
        
    }
    
    func copyOverData(){
        
        if WorkoutService.workoutArray.count != 0{
            copiedVariable = []
            for x in WorkoutService.workoutArray{
                copiedVariable.append(x)
            }
        }
        if WorkoutService.workoutArray.count == 0{
            for x in copiedVariable{
                WorkoutService.workoutArray.append(x)
            }
        }
    }
    
}


extension WODViewController: UITableViewDataSource{
    
    
    //TableViews
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var returnedValue = 0
        
        if WorkoutService.workoutArray.count != 0{
            for workout in WorkoutService.workoutArray {
                if CalendarViewController.selectedDateVarString == workout.dateCreated{
                    returnedValue += 1
                }
            }
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
                        returnedValue = cell
                    case 1:
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseLabelsCell", for: indexPath) as! ExerciseLabelsCell
                        returnedValue = cell
                    // + 2 because middle = 2 + numberOfSets
                    case let x where x > 1 && x < exercise.numberOfSets[0] + 2 :
                        let cell = tableView.dequeueReusableCell(withIdentifier: "SetDataCell", for: indexPath) as! SetDataCell
                        returnedValue = cell
                    case exercise.numberOfSets[0]+2:
                        let cell = tableView.dequeueReusableCell(withIdentifier: "AddingSetCell", for: indexPath) as! AddingSetCell
                        cell.delegate = self as AddingSetCellDelegate
                        returnedValue = cell
                    default:
                        fatalError("Error unexpected Indexpath.row")
                    }
                }
            }
        }
        
        print("Workout service workout array not empty")
        return returnedValue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedExercise = WorkoutService.workoutArray[indexPath.section]
    }
    
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    //
    //
    //        for exercise in WorkoutService.workoutArray{
    //            if indexPath.section == exercise.sectionNumber && CalendarViewController.selectedDateVarString == exercise.dateCreated{
    //                if indexPath.row != 0 || indexPath.row != 1 || indexPath.row != exercise.numberOfSets[0]+2{
    //                    if editingStyle == .delete {
    //                        selectedExercise = exercise
    //                        exercise.numberOfSets[0] -= 1
    //
    //                        print("selected exercise")
    //                        print(selectedExercise)
    //                        print(selectedExercise.sectionNumber)
    //                        exerciseListTableView.deleteRows(at: [IndexPath(row: exercise.numberOfSets[0]+1, section: exercise.sectionNumber)], with: .fade)
    //
    //                        saveWorkout()
    //                    }
    //                }
    //
    //            }
    //        }
    
    
    func setupTableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        var returnedValue = UITableViewCellEditingStyle.none
        for exercise in WorkoutService.workoutArray{
            if indexPath.row != 0 || indexPath.row != 1 || indexPath.row != exercise.numberOfSets[0]+2{
                returnedValue = UITableViewCellEditingStyle.none
                print("Style none")
            } else {
                returnedValue = UITableViewCellEditingStyle.delete
                print("Style delete")
            }
        }
        return returnedValue
    }
    
    
    
}



extension WODViewController: AddingSetCellDelegate{
    
    func reloadingNumberOfSets(cell: AddingSetCell) {
        
        let indexPath = exerciseListTableView.indexPath(for: cell)!
        
        for exercise in WorkoutService.workoutArray{
            if indexPath.section == exercise.sectionNumber && CalendarViewController.selectedDateVarString == exercise.dateCreated{
                selectedExercise = exercise
                exercise.numberOfSets[0] += 1
                
                print("selected exercise")
                print(selectedExercise)
                print(selectedExercise.sectionNumber)
                exerciseListTableView.insertRows(at: [IndexPath(row: exercise.numberOfSets[0]+1, section: exercise.sectionNumber)], with: .fade)
                
                saveWorkout()
                
                
            }
        }
    }
    
}










