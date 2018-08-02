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
        
        formatInputFields()
        
        
        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 3
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IBActions
    
    @IBAction func weightTextFieldTapped(_ sender: Any) {
        
    }
    
    @IBAction func heightTextFieldTapped(_ sender: Any) {
        
    }
    
    @IBAction func ageTextFieldTapped(_ sender: Any) {
        
    }
    
    @IBAction func genderTextFieldTapped(_ sender: Any) {
        
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
        
        
    }

    @IBAction func volumeSegmentedControlTapped(_ sender: Any) {
        switch volumeSegmentedControl.selectedSegmentIndex{
        case 0: lengthOfWorkoutSlider.value = 30.0
        case 1: lengthOfWorkoutSlider.value = 45.0
        case 2: lengthOfWorkoutSlider.value = 80.0
        case 3: lengthOfWorkoutSlider.value = 110.0
        default: fatalError("Out of Range")
        }
        lengthOfWorkoutLabel.text = "\(Int(lengthOfWorkoutSlider.value.rounded())) Minutes"
        
    }
    
    @IBAction func weekSliderTapped(_ sender: Any) {
        numberOfWeeksLabel.text = "\(Int(weekSlider.value.rounded())) Weeks"
        
    }
    
    @IBAction func lengthOfWorkoutSlider(_ sender: Any) {
        lengthOfWorkoutLabel.text = "\(Int(lengthOfWorkoutSlider.value.rounded())) Minutes"
        switch  lengthOfWorkoutSlider.value {
        case let x where x > 0 && x <= 30: volumeSegmentedControl.selectedSegmentIndex = 0
            case let x where x > 30 && x <= 60: volumeSegmentedControl.selectedSegmentIndex = 1
            case let x where x > 60 && x <= 90: volumeSegmentedControl.selectedSegmentIndex = 2
            case let x where x > 90 && x <= 120: volumeSegmentedControl.selectedSegmentIndex = 3
        default: fatalError("Out of Range")
        }
        
    }
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        
        
        writeWorkoutProgram()
        
        
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        formatInputFields()
    }
    
    
    
    //Dismiss Keyboard
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func formatInputFields(){
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
            lengthOfWorkoutSlider.setValue(Float(UserMetricsService.userMetricsArray[0].lengthOfWorkout), animated: true)
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
        
        numberOfWeeksLabel.text = "\(Int(weekSlider.value.rounded())) Weeks"
        lengthOfWorkoutLabel.text = "\(Int(lengthOfWorkoutSlider.value.rounded())) Minutes"
        showDatePicker()
        UserMetricsViewController.datePicker.date = CalendarViewController.selectedDateVar
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtDatePicker.text = formatter.string(from: CalendarViewController.selectedDateVar)
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
        
        WorkoutService.deleteSectionSender = "UserMetrics"
        
        UserMetricsViewController.dateTracker = UserMetricsViewController.datePicker.date
        
        //Deleting old workouts
        for x in 1...Int(self.weekSlider.value*(7)){
            
            for workout in WorkoutService.workoutArray {
                
                if workout.dateCreated == UserMetricsViewController.dateTracker.toString(dateFormat: "dd-MMM-yyyy"){
                    print("removing")
                    print(workout.exerciseName)
                    print(workout.dateCreated)
                    print(UserMetricsViewController.dateTracker.toString(dateFormat: "dd-MMM-yyyy"))
                    
                    WorkoutService.workoutArray = []
                    WorkoutService.removeWorkout(exerciseName: workout.dateCreated, numberOfReps: workout.numberOfReps, numberOfSets: workout.numberOfReps, weight: workout.weight, sectionNumber: workout.sectionNumber, alreadyAdded: workout.alreadyAdded, dateCreated: workout.dateCreated, bodyPart: workout.bodyPart, restDays: workout.restDays, intensity: workout.intensity)
                    WODViewController.copiedVariable.remove(at: WODViewController.copiedVariable.index(where: {$0 === workout})!)
                }
                
                UserMetricsViewController.dateTracker = Calendar.current.date(byAdding: .day, value: 1, to: UserMetricsViewController.dateTracker)!
            }
            
             WODViewController.copyOverData()
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
                
            case let x where x >= 0 && x < 16: numberOfExercises = 1
            case let x where x >= 15 && x < 31: numberOfExercises = 2
            case let x where x >= 30 && x < 46: numberOfExercises = 3
            case let x where x >= 45 && x < 61: numberOfExercises = 4
            case let x where x >= 60 && x < 76: numberOfExercises = 5
            case let x where x >= 75 && x < 91: numberOfExercises = 6
            case let x where x >= 90 && x < 106: numberOfExercises = 7
            case let x where x >= 105 && x < 121: numberOfExercises = 8
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
                        
                    case 0: selectedBodyPartArray = self.listOfExercises.filter {$0.bodyPart == ExerciseModel.BodyPart.chest.rawValue || $0.bodyPart == ExerciseModel.BodyPart.bicep.rawValue || $0.bodyPart == ExerciseModel.BodyPart.tricep.rawValue || $0.bodyPart == ExerciseModel.BodyPart.back.rawValue || $0.bodyPart == ExerciseModel.BodyPart.delt.rawValue}
                    case 1: selectedBodyPartArray = self.listOfExercises.filter {$0.bodyPart == ExerciseModel.BodyPart.quads.rawValue || $0.bodyPart == ExerciseModel.BodyPart.hamstrings.rawValue || $0.bodyPart == ExerciseModel.BodyPart.calves.rawValue }
                    case 2: selectedBodyPartArray = self.listOfExercises
                    default: return
                        
                    }
                    
                    print("Selected Body Part Array")
                    print(selectedBodyPartArray)
                    
//                    switch self.volumeSegmentedControl.selectedSegmentIndex{
//
//                    case 0: self.selectedExercise.numberOfSets[0] = 8
//                    case 1: self.selectedExercise.numberOfSets[0] = 6
//                    case 2: self.selectedExercise.numberOfSets[0] = 4
//                    case 3: self.selectedExercise.numberOfSets[0] = 2
//                    default: fatalError("Out of range")
//
//                    }
                    
                    var numberOfReps = 0
                    
                    switch self.goalSegmentedControl.selectedSegmentIndex {
                        
                    case 0: numberOfReps = 2
                        self.selectedExercise.numberOfSets[0] = 8
                    case 1: numberOfReps = 6
                        self.selectedExercise.numberOfSets[0] = 6
                    case 2: numberOfReps = 12
                        self.selectedExercise.numberOfSets[0] = 4
                    case 3: numberOfReps = 15
                        self.selectedExercise.numberOfSets[0] = 2
                    default: fatalError("Out of Range")
                        
                    }
                    
                    self.selectedExercise.numberOfReps.remove(at: 0)
                    self.selectedExercise.weight.remove(at: 0)
                    for x in 1...self.selectedExercise.numberOfSets[0]{
                        self.selectedExercise.numberOfReps.append(numberOfReps)
                        self.selectedExercise.weight.append(0)
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


