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
    
    
    //Overide Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        listOfExercises = listOfExercisesReference.listOfExercises
        
        timerLabel.text = String(timerLength)
        timerProgressView.progress = Float(timerLength/savedTime)
        timerProgressView.barHeight = self.view.frame.height*0.005
        
        configureTableView()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IB Actions
    @IBAction func newExerciseTapped(_ sender: Any) {
        
    }
    
    
    @IBAction func saveWorkoutTapped(_ sender: Any) {
        saveWorkout()
    }
    
    
    @IBAction func unwindWithSegueToHome(_ segue: UIStoryboardSegue){
        
    }
    
    //Setting Table View
    func checkDuplicates(){
        
        if WorkoutService.workoutArray.count == 0{
            formatTableView()
            return
        }

        
        for exercise in WorkoutService.workoutArray {
            if selectedExercise.alreadyAdded == false && selectedExercise.exerciseName != exercise.exerciseName{
                formatTableView()
            }
        }
        
    }
    
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
        
        timerLength -= 1
        timerLabel.text = String(timerLength)
        timerProgressView.progress = Float(Double(timerLength)/Double(savedTime))
        
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
            
            for workout in WorkoutService.workoutArray {
                if CalendarViewController.selectedDateVarString == workout.dateCreated && selectedExercise.exerciseName == workout.exerciseName{
                    
                    WorkoutService.currentSectionNumber = String(workout.sectionNumber)
                    
                    WorkoutService.updateWorkout(exerciseName: workout.exerciseName, numberOfReps: workout.numberOfReps, numberOfSets: workout.numberOfSets, sectionNumber: workout.sectionNumber, alreadyAdded: workout.alreadyAdded, dateCreated: CalendarViewController.selectedDateVarString)
                    
                    selectedExercise.alreadyAdded = false
                    
                    print("Date Exists")
                    return
                    
                } else {
                    
                    WorkoutService.currentSectionNumber = String(exerciseListTableView.numberOfSections)
                    
                    WorkoutService.writeWorkout(exerciseName: selectedExercise.exerciseName, numberOfReps: selectedExercise.numberOfReps, numberOfSets: selectedExercise.numberOfSets, sectionNumber: Int(WorkoutService.currentSectionNumber)!, alreadyAdded: selectedExercise.alreadyAdded, dateCreated: CalendarViewController.selectedDateVarString)
                    
                    selectedExercise.alreadyAdded = false
                    
                    exerciseListTableView.insertSections([Int(WorkoutService.currentSectionNumber)!], with: .fade)
                    
                    print("Date Exists Not")
                    return
                }
            }
            
        } else {
            
            
            WorkoutService.writeWorkout(exerciseName: selectedExercise.exerciseName, numberOfReps: selectedExercise.numberOfReps, numberOfSets: selectedExercise.numberOfSets, sectionNumber: selectedExercise.sectionNumber, alreadyAdded: selectedExercise.alreadyAdded, dateCreated: CalendarViewController.selectedDateVarString)
            
            print("Empty")
        }
        
        exerciseListTableView.reloadData()
        
//        exerciseListTableView.reloadSections([0], with: .fade)
        
    }
}


extension WODViewController: UITableViewDataSource{
    
    
    //TableViews
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var returnedValue = 0
        
        if WorkoutService.workoutArray.count != 0{
            returnedValue = WorkoutService.workoutArray.count
        }
        
        return returnedValue
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var valuedReturned = ""
        if WorkoutService.workoutArray.count != 0{
            
            valuedReturned = WorkoutService.workoutArray[section].exerciseName
        }
        return valuedReturned
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnedValue = 0
        if WorkoutService.workoutArray.count != 0{
            for exercise in WorkoutService.workoutArray {
                if exercise.sectionNumber == section {
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
    
    
    
}



extension WODViewController: AddingSetCellDelegate{
    
    func reloadingNumberOfSets(cell: AddingSetCell) {
        
        let indexPath = exerciseListTableView.indexPath(for: cell)!
        
        for exercise in WorkoutService.workoutArray{
            if indexPath.section == exercise.sectionNumber{
                selectedExercise = exercise
                WorkoutService.workoutArray[exercise.sectionNumber].numberOfSets[0] += 1
                saveWorkout()
                exerciseListTableView.insertRows(at: [IndexPath(row: selectedExercise.numberOfSets[0]+1, section: selectedExercise.sectionNumber)], with: .fade)
                
                
            }
        }
    }


}











