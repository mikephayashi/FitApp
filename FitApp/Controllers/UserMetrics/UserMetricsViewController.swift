//
//  UserMetricsViewController.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/25/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit


class UserMetricsViewController: UIViewController {
    
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet var goalSegmentedControl: UISegmentedControl!
    @IBOutlet var bodyPartSegmentedControl: UISegmentedControl!
    @IBOutlet var numberOfWeeksLabel: UILabel!
    @IBOutlet var weekSlider: UISlider!
    @IBOutlet var txtDatePicker: UITextField!
    @IBOutlet var volumeSegmentedControl: UISegmentedControl!
    @IBOutlet var lengthOfWorkoutSlider: UISlider!
    @IBOutlet var lengthOfWorkoutLabel: UILabel!
    
    static var datePicker = UIDatePicker()
    
    //Exercise Properties
    var selectedExercise = ExerciseModel(exerciseName: "", numberOfReps: [1], numberOfSets: [1], weight: [1], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: "", restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue)
    
    //List of Exercises
    let listOfExercisesReference = ListOfExercises()
    var listOfExercises = [ExerciseModel]()
    
    
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
        
        if UserMetricsService.userMetricsArray.count != 0{
            weightTextField.text = String(UserMetricsService.userMetricsArray[0].weight)
            heightTextField.text = String(UserMetricsService.userMetricsArray[0].height)
            ageTextField.text = String(UserMetricsService.userMetricsArray[0].age)
            genderTextField.text = String(UserMetricsService.userMetricsArray[0].gender)
            goalSegmentedControl.selectedSegmentIndex = UserMetricsService.userMetricsArray[0].goal
            bodyPartSegmentedControl.selectedSegmentIndex = UserMetricsService.userMetricsArray[0].bodyPart
            volumeSegmentedControl.selectedSegmentIndex = UserMetricsService.userMetricsArray[0].volume
            weekSlider.setValue(Float(UserMetricsService.userMetricsArray[0].numberOfWeeks), animated: true)
            numberOfWeeksLabel.text = String(weekSlider.value)
            lengthOfWorkoutSlider.setValue(Float(UserMetricsService.userMetricsArray[0].numberOfWeeks), animated: true)
            lengthOfWorkoutLabel.text = String(lengthOfWorkoutSlider.value)
        } else {
            weightTextField.text = String(0)
            heightTextField.text = String(0)
            ageTextField.text = String(0)
            genderTextField.text = String(0)
            goalSegmentedControl.selectedSegmentIndex = 0
            bodyPartSegmentedControl.selectedSegmentIndex = 0
            volumeSegmentedControl.selectedSegmentIndex = 0
            weekSlider.setValue(Float(0), animated: true)
            numberOfWeeksLabel.text = String(weekSlider.value)
            lengthOfWorkoutSlider.setValue(Float(0), animated: true)
            lengthOfWorkoutLabel.text = String(lengthOfWorkoutSlider.value)
        }
        
        numberOfWeeksLabel.text = "\(weekSlider.value.rounded()) Weeks"
        lengthOfWorkoutLabel.text = "\(lengthOfWorkoutSlider.value.rounded()) Minutes"
        showDatePicker()
        UserMetricsViewController.datePicker.date = CalendarViewController.selectedDateVar
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtDatePicker.text = formatter.string(from: CalendarViewController.selectedDateVar)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IBActions
    
    @IBAction func weightTextFieldTapped(_ sender: Any) {
        updateMetrics()
    }
    @IBAction func heightTextFieldTapped(_ sender: Any) {
        updateMetrics()
    }
    @IBAction func ageTextFieldTapped(_ sender: Any) {
        updateMetrics()
    }
    @IBAction func genderTextFieldTapped(_ sender: Any) {
        updateMetrics()
    }
    
    @IBAction func goalSegmentedControlTapped(_ sender: Any) {
        print(bodyPartSegmentedControl.selectedSegmentIndex)
        switch bodyPartSegmentedControl.selectedSegmentIndex {
        case 0: print(bodyPartSegmentedControl.selectedSegmentIndex)
        case 1: print(bodyPartSegmentedControl.selectedSegmentIndex)
        case 2: print(bodyPartSegmentedControl.selectedSegmentIndex)
        case 3: print(bodyPartSegmentedControl.selectedSegmentIndex)
        default:
            return
        }
        
        updateMetrics()
    }
    
    @IBAction func bodyPartSegmentedControltapped(_ sender: Any) {
        
        print(goalSegmentedControl.selectedSegmentIndex)
        switch goalSegmentedControl.selectedSegmentIndex {
        case 0: print(goalSegmentedControl.selectedSegmentIndex)
        case 1: print(goalSegmentedControl.selectedSegmentIndex)
        case 2: print(goalSegmentedControl.selectedSegmentIndex)
        case 3: print(goalSegmentedControl.selectedSegmentIndex)
        default:
            return
        }
        
        updateMetrics()
    }
    
    
    @IBAction func volumeSegmentedControlTapped(_ sender: Any) {
        updateMetrics()
    }
    
    @IBAction func weekSliderTapped(_ sender: Any) {
        numberOfWeeksLabel.text = "\(weekSlider.value.rounded()) Weeks"
        updateMetrics()
    }
    
    
    @IBAction func lengthOfWorkoutSlider(_ sender: Any) {
        lengthOfWorkoutLabel.text = "\(lengthOfWorkoutSlider.value.rounded()) Minutes"
        updateMetrics()
    }
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        
        
        writeWorkoutProgram()
        
        
    }
    
    
    
    //Dismiss Keyboard
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func updateMetrics(){
        if UserMetricsService.userMetricsArray.count != 0{
            for metric in UserMetricsService.userMetricsArray{
                //                checkMetrics()
                
                if CalendarViewController.selectedDateVarString == metric.date{
                    UserMetricsService.updateUserMetrics(weight: Int(weightTextField.text!)!, height: Int(heightTextField.text!)!, age: Int(ageTextField.text!)!, gender: Int(genderTextField.text!)!, date: CalendarViewController.selectedDateVarString, goal: goalSegmentedControl.selectedSegmentIndex, bodyPart: bodyPartSegmentedControl.selectedSegmentIndex, volume: Int(volumeSegmentedControl.selectedSegmentIndex), lengthOfWorkout: Int(lengthOfWorkoutSlider.value.rounded()), numberOfWeeks: Int(weekSlider.value.rounded()))
                    
                    print("Date Exists")
                    
                    return
                    
                } else {
                    
                    UserMetricsService.writeUserMetrics(weight: Int(weightTextField.text!)!, height: Int(heightTextField.text!)!, age: Int(ageTextField.text!)!, gender: Int(genderTextField.text!)!, date: CalendarViewController.selectedDateVarString, goal: goalSegmentedControl.selectedSegmentIndex, bodyPart: bodyPartSegmentedControl.selectedSegmentIndex, volume: Int(volumeSegmentedControl.selectedSegmentIndex),lengthOfWorkout: Int(lengthOfWorkoutSlider.value.rounded()), numberOfWeeks: Int(weekSlider.value.rounded()))
                    
                    print("Date Exists Not")
                    
                    return
                }
            }
            
        } else {
            
            UserMetricsService.writeUserMetrics(weight: Int(weightTextField.text!)!, height: Int(heightTextField.text!)!, age: Int(ageTextField.text!)!, gender: Int(genderTextField.text!)!, date: CalendarViewController.selectedDateVarString, goal: goalSegmentedControl.selectedSegmentIndex, bodyPart: bodyPartSegmentedControl.selectedSegmentIndex, volume: Int(volumeSegmentedControl.selectedSegmentIndex), lengthOfWorkout: Int(lengthOfWorkoutSlider.value.rounded()), numberOfWeeks: Int(weekSlider.value.rounded()))
        }
    }
    
    //Date Picker
    func showDatePicker(){
        //Formate Date
        
        UserMetricsViewController.datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtDatePicker.inputAccessoryView = toolbar
        txtDatePicker.inputView = UserMetricsViewController.datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtDatePicker.text = formatter.string(from: UserMetricsViewController.datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
}

//Writing Workout Program
extension UserMetricsViewController{
    
    static var dateTracker = UserMetricsViewController.datePicker.date
    
    func writeWorkoutProgram(){
        
        UserMetricsViewController.dateTracker = UserMetricsViewController.datePicker.date
        
        //Deleting old workouts
        for x in 1...Int(self.weekSlider.value*(7)){
            
            for workout in WorkoutService.workoutArray {
                
                if workout.dateCreated == UserMetricsViewController.dateTracker.toString(dateFormat: "dd-MMM-yyyy"){
                    print("removing")
                    print(workout.exerciseName)
                    print(workout.dateCreated)
                    print(UserMetricsViewController.dateTracker.toString(dateFormat: "dd-MMM-yyyy"))
                    
                    
                    WorkoutService.removeWorkout(exerciseName: workout.dateCreated, numberOfReps: workout.numberOfReps, numberOfSets: workout.numberOfReps, weight: workout.weight, sectionNumber: workout.sectionNumber, alreadyAdded: workout.alreadyAdded, dateCreated: workout.dateCreated, bodyPart: workout.bodyPart, restDays: workout.restDays, intensity: workout.intensity)
                }
                
                UserMetricsViewController.dateTracker = Calendar.current.date(byAdding: .day, value: 1, to: UserMetricsViewController.dateTracker)!
            }
        }
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            print("dispatch")
            
            var selectedBodyPartArray = self.listOfExercises
            
            //Writing new workouts
            UserMetricsViewController.dateTracker = UserMetricsViewController.datePicker.date
            
            var formattedDate = UserMetricsViewController.datePicker.date.toString(dateFormat: "dd-MMM-yyyy")
            self.selectedExercise = self.listOfExercises[0]
            WorkoutService.currentSectionNumber = "0"
            
            print("Date Picker \(UserMetricsViewController.datePicker.date)")
            
            
            var counter = 1
            var numberOfExercises = 0
            
            print("Length of workout slider")
            print(self.lengthOfWorkoutSlider.value)
            
            switch self.lengthOfWorkoutSlider.value {
                
            case let x where x > 0 && x < 41: numberOfExercises = 1
            case let x where x > 40 && x < 81: numberOfExercises = 2
            case let x where x > 80 && x < 121: numberOfExercises = 3
            default: return
                
            }

            
            for x in 1...Int(self.weekSlider.value*(7)){
                
                WorkoutService.currentSectionNumber = "0"
                
                formattedDate = UserMetricsViewController.dateTracker.toString(dateFormat: "dd-MMM-yyyy")
                
                for x in counter...numberOfExercises{
                    
                    self.selectedExercise = selectedBodyPartArray[Int(arc4random_uniform(UInt32(selectedBodyPartArray.count)))]
                    
                    
                    print("Entered for in loop")
                    print(x)
                    
                    
                    
                    //MARK: USER METRICS TO WORKOUT CALCULATOR
                    
                    
                    
                   
                    
                    
                    switch self.bodyPartSegmentedControl.selectedSegmentIndex {
                        
                    case 0: selectedBodyPartArray = self.listOfExercises.filter {$0.bodyPart == ExerciseModel.BodyPart.chest.rawValue}
                    case 1: selectedBodyPartArray = self.listOfExercises.filter {$0.bodyPart == ExerciseModel.BodyPart.quads.rawValue}
                    case 2: selectedBodyPartArray = self.listOfExercises
                    default: return
                        
                    }
                    
                    switch self.goalSegmentedControl.selectedSegmentIndex{
                        
                    case 0: self.selectedExercise.numberOfReps[0] = 2
                    case 1: self.selectedExercise.numberOfReps[0] = 6
                    case 2: self.selectedExercise.numberOfReps[0] = 12
                    case 3: self.selectedExercise.numberOfReps[0] = 15
                    default: return
                        
                    }
                    
                    var numberOfReps = 0
                    
                    switch self.volumeSegmentedControl.selectedSegmentIndex {
                        
                    case 0: numberOfReps = 2
                    case 1: numberOfReps = 4
                    case 2: numberOfReps = 6
                    case 3: numberOfReps = 8
                    default: return
                        
                    }
                    
                    for x in 1...self.selectedExercise.numberOfSets[0]{
                        self.selectedExercise.numberOfReps.append(numberOfReps)
                    }

                    //END
                    
                    
                    

                    
                    
                    WorkoutService.writeProgram(exerciseName: self.selectedExercise.exerciseName, numberOfReps: self.selectedExercise.numberOfReps, numberOfSets: self.selectedExercise.numberOfSets, weight: self.selectedExercise.weight, sectionNumber: Int(WorkoutService.currentSectionNumber)!, alreadyAdded: true, dateCreated: formattedDate, bodyPart: self.selectedExercise.bodyPart, restDays: self.selectedExercise.restDays,intensity: self.selectedExercise.intensity)
                    
                    WorkoutService.currentSectionNumber = String(Int(WorkoutService.currentSectionNumber)!+1)
                }
                
                UserMetricsViewController.dateTracker = Calendar.current.date(byAdding: .day, value: 1, to: UserMetricsViewController.dateTracker)!
            }
            
            WODViewController.copyOverData()
            
        }
        
    }
    
    
}


