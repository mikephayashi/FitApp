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
    var selectedExercise = ExerciseModel(exerciseName: "", numberOfReps: [1], numberOfSets: [1], weight: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: "", restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    
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
    static var copiedVariable = [ExerciseModel]()
    
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
            WODViewController.copyOverData()
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Appear")
        print(WorkoutService.workoutArray)
        print(WODViewController.copiedVariable)
        exerciseListTableView.reloadData()
        
        for exercise in WorkoutService.workoutArray{
            
            print("stuff here")
            
            print(previousDate)
            print(CalendarViewController.selectedDateVarString)
            
            if previousDate != CalendarViewController.selectedDateVarString{
                print("loading data")
                print(WorkoutService.workoutArray)
                print(WODViewController.copiedVariable)
                var exerciseArray: IndexSet = []
                var numberOfSections = exerciseListTableView.numberOfSections
                
                if exerciseListTableView.numberOfSections != 0 {
                    print("deleting stuff")
                    for section in 0...exerciseListTableView.numberOfSections-1 {
                        exerciseArray.insert(section)
                    }
                    WorkoutService.workoutArray = []
                    exerciseListTableView.deleteSections(exerciseArray, with: .none)
                    WODViewController.copyOverData()
                    print(WODViewController.copiedVariable)
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
                    
                    WorkoutService.updateWorkout(exerciseName: workout.exerciseName, numberOfReps: workout.numberOfReps, numberOfSets: workout.numberOfSets, weight: workout.weight, sectionNumber: workout.sectionNumber, alreadyAdded: workout.alreadyAdded, dateCreated: CalendarViewController.selectedDateVarString, bodyPart: selectedExercise.bodyPart, restDays: selectedExercise.restDays, intensity: selectedExercise.intensity)
                    
                    selectedExercise.alreadyAdded = false
                    WODViewController.copyOverData()
                    
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
                        
                        WorkoutService.writeWorkout(exerciseName: selectedExercise.exerciseName, numberOfReps: selectedExercise.numberOfReps, numberOfSets: selectedExercise.numberOfSets, weight: selectedExercise.weight, sectionNumber: Int(WorkoutService.currentSectionNumber)!, alreadyAdded: selectedExercise.alreadyAdded, dateCreated: CalendarViewController.selectedDateVarString, bodyPart: selectedExercise.bodyPart, restDays: selectedExercise.restDays, intensity: selectedExercise.intensity)
                        
                        selectedExercise.alreadyAdded = false
                        
                        exerciseListTableView.insertSections([Int(WorkoutService.currentSectionNumber)!], with: .fade)
                        
                        WODViewController.copyOverData()
                        
                        print("Date Exists Not")
                        return
                    }
                }
            }
            
        } else {
            
            
            WorkoutService.writeWorkout(exerciseName: selectedExercise.exerciseName, numberOfReps: selectedExercise.numberOfReps, numberOfSets: selectedExercise.numberOfSets, weight: selectedExercise.weight, sectionNumber: selectedExercise.sectionNumber, alreadyAdded: selectedExercise.alreadyAdded, dateCreated: CalendarViewController.selectedDateVarString, bodyPart: selectedExercise.bodyPart, restDays: selectedExercise.restDays, intensity: selectedExercise.intensity)
            
            selectedExercise.alreadyAdded = false
            
            WODViewController.copyOverData()
            
            print("Empty")
        }
        
        exerciseListTableView.reloadData()
        print("checking workout array")
        print(WorkoutService.workoutArray)
        
    }
    
    static func copyOverData(){
        
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
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
                        cell.setNumberLabel.text = "Set # \(indexPath.row-1)"
                        cell.numberOfRepsTextField.text = String(exercise.numberOfReps[indexPath.row-2])
                        print("Weight")
                        print(exercise.weight)
                        cell.weightTextField.text = String(exercise.weight[indexPath.row-2])
                        cell.delegate = self as SetDataCellDelegate
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

extension WODViewController: SetDataCellDelegate{
    
    func savingWeight(cell: SetDataCell, weight: Int) {
        
        let indexPath = exerciseListTableView.indexPath(for: cell)!
        
        for exercise in WorkoutService.workoutArray{
            if indexPath.section == exercise.sectionNumber && CalendarViewController.selectedDateVarString == exercise.dateCreated{
                
                selectedExercise = exercise
                selectedExercise.weight[indexPath.row-2] = weight
                
                print("Saving Reps called")
                print(selectedExercise.weight)
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
                
                print("Saving Reps called")
                print(selectedExercise.numberOfReps)
                saveWorkout()
                
                
            }
        }
    }
    
    func deleteRow(cell: SetDataCell){
        
        let indexPath = exerciseListTableView.indexPath(for: cell)!
        
        for exercise in WorkoutService.workoutArray{
            if indexPath.section == exercise.sectionNumber && CalendarViewController.selectedDateVarString == exercise.dateCreated{
                if indexPath.row != 0 || indexPath.row != 1 || indexPath.row != exercise.numberOfSets[0]+2{
                        selectedExercise = exercise
                        exercise.numberOfSets[0] -= 1
                        exercise.numberOfReps.remove(at: indexPath.row-2)
                        exercise.weight.remove(at: indexPath.row-2)
                        
                        print("selected exercise")
                        print(selectedExercise)
                        print(selectedExercise.sectionNumber)
                        exerciseListTableView.deleteRows(at: [IndexPath(row: exercise.numberOfSets[0]+1, section: exercise.sectionNumber)], with: .fade)
                        
                        saveWorkout()
                    }
                
            }
        }
        
    }
    
}



extension WODViewController: AddingSetCellDelegate{
    
    func reloadingNumberOfSets(cell: AddingSetCell) {
        
        let indexPath = exerciseListTableView.indexPath(for: cell)!
        
        for exercise in WorkoutService.workoutArray{
            if indexPath.section == exercise.sectionNumber && CalendarViewController.selectedDateVarString == exercise.dateCreated{
                selectedExercise = exercise
                exercise.numberOfSets[0] += 1
                exercise.numberOfReps.append(1)
                exercise.weight.append(0)
                
                print("selected exercise")
                print(selectedExercise)
                print(selectedExercise.sectionNumber)
                exerciseListTableView.insertRows(at: [IndexPath(row: exercise.numberOfSets[0]+1, section: exercise.sectionNumber)], with: .fade)
                
                saveWorkout()
                
                
            }
        }
    }
    
}










