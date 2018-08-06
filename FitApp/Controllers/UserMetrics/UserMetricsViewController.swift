//
//  UserMetricsViewController.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/25/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit


class UserMetricsViewController: UIViewController {
    
    
    //    @IBOutlet weak var weightTextField: UITextField!
    //    @IBOutlet weak var heightTextField: UITextField!
    //    @IBOutlet weak var ageTextField: UITextField!
    //    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var txtDatePicker: UITextField!
    @IBOutlet weak var numberOfWeeksLabel: UILabel!
    @IBOutlet weak var weekSlider: UISlider!
    @IBOutlet weak var bodyPartSegmentedControl: UISegmentedControl!
    @IBOutlet weak var workoutTypeSegmentControl: UISegmentedControl!
    @IBOutlet weak var goalSegmentedControl: UISegmentedControl!
    @IBOutlet weak var volumeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var lengthOfWorkoutLabel: UILabel!
    @IBOutlet weak var lengthOfWorkoutSlider: UISlider!
    @IBOutlet weak var exerciseSelectorTableView: UITableView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    
    
    //Arrays
    var selectedBodyPartArray = [ExerciseModel]()
    var selectionOfWorkoutTypesArray = [String]()
    static var clickedWorkoutsArray = [String]()
    var clickedArray = [Int]()
    
    //Date Picker
    static var datePicker = UIDatePicker()
    
    //Exercise Properties
    var selectedExercise = ExerciseModel(exerciseName: "", numberOfReps: [1], numberOfSets: [1], weight: [1], completed: [0], sectionNumber: 0, alreadyAdded: false, dateCreated: "", bodyPart: "", restDays: 2, intensity: ExerciseModel.Intensity.primary.rawValue, workoutType: ExerciseModel.WorkoutType.foundational.rawValue)
    
    //List of Exercises
    let listOfExercisesReference = ListOfExercises()
    var listOfExercises = [ExerciseModel]()
    
    
    //Overide Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(tap)
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        listOfExercises = listOfExercisesReference.listOfExercises
        selectionOfWorkoutTypesArray = ListOfExercises.listOfExeciseTypes
        
        
        //remove separators for empty cells
        exerciseSelectorTableView.tableFooterView = UIView()
        //remove separators from cells
        exerciseSelectorTableView.separatorStyle = .none
        //remove scroll
        exerciseSelectorTableView.showsVerticalScrollIndicator = false
        formatInputFields()
        WODViewController.copyOverData()
        
        formatViews()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtDatePicker.inputView = UserMetricsViewController.datePicker
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM-dd-yyyy"
        txtDatePicker.text = formatter.string(from: CalendarViewController.selectedDateVar)
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
    
    @IBAction func weekSliderTapped(_ sender: Any) {
        numberOfWeeksLabel.text = "\(Int(weekSlider.value.rounded())) Weeks"
        
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
        
        updateMetrics()
        writeWorkoutProgram()
        
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        formatInputFields()
    }
    
    @IBAction func bodyPartSegmentedControlTapped(_ sender: Any) {
        
        workoutTypeSegmentControl.selectedSegmentIndex = UISegmentedControlNoSegment
        
        
        switch bodyPartSegmentedControl.selectedSegmentIndex{
        case 0: selectionOfWorkoutTypesArray = ListOfExercises.listOfExeciseTypes.filter {$0 == ExerciseModel.BodyPart.chest.rawValue || $0 == ExerciseModel.BodyPart.back.rawValue || $0 == ExerciseModel.BodyPart.bicep.rawValue || $0 == ExerciseModel.BodyPart.tricep.rawValue || $0 == ExerciseModel.BodyPart.delt.rawValue}
        case 1: selectionOfWorkoutTypesArray = ListOfExercises.listOfExeciseTypes.filter {$0 == ExerciseModel.BodyPart.quads.rawValue || $0 == ExerciseModel.BodyPart.hamstrings.rawValue || $0 == ExerciseModel.BodyPart.calves.rawValue || $0 == ExerciseModel.BodyPart.olympicLifts.rawValue}
        case 2: selectionOfWorkoutTypesArray = ListOfExercises.listOfExeciseTypes
        default: fatalError("Index out of range")
        }
        
        UserMetricsViewController.clickedWorkoutsArray = selectionOfWorkoutTypesArray
        clickedArray = []
        for _ in UserMetricsViewController.clickedWorkoutsArray {
            clickedArray.append(1)
        }
        exerciseSelectorTableView.reloadData()
    }
    
    @IBAction func workoutTypeSegmentedControlTapped(_ sender: Any) {
        
        bodyPartSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        
        switch workoutTypeSegmentControl.selectedSegmentIndex{
        case 0: selectionOfWorkoutTypesArray = ListOfExercises.listOfExeciseTypes
        case 1: selectionOfWorkoutTypesArray = ListOfExercises.listOfExeciseTypes.filter {$0 == ExerciseModel.BodyPart.cardio.rawValue}
        case 2: selectionOfWorkoutTypesArray = ListOfExercises.listOfExeciseTypes.filter {$0 != ExerciseModel.BodyPart.cardio.rawValue}
        default: fatalError("Index out of range")
        }
        UserMetricsViewController.clickedWorkoutsArray = selectionOfWorkoutTypesArray
        clickedArray = []
        for _ in UserMetricsViewController.clickedWorkoutsArray {
            clickedArray.append(1)
        }
        exerciseSelectorTableView.reloadData()
        
    }
    
    //Format
    func formatViews(){
        
        updateButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        updateButton.layer.shadowOpacity = 0.05
        updateButton.layer.cornerRadius = 8
        updateButton.layer.shadowRadius = 3
        updateButton.layer.shadowColor = UIColor(rgb: 0x0090FF).cgColor
        updateButton.layer.masksToBounds = true
        updateButton.layer.borderWidth = 0
        updateButton.layer.borderColor = UIColor(rgb: 0x00487F).cgColor
        
        cancelButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        cancelButton.layer.shadowOpacity = 0.05
        cancelButton.layer.cornerRadius = 8
        cancelButton.layer.shadowRadius = 3
        cancelButton.layer.shadowColor = UIColor(rgb: 0x0090FF).cgColor
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.borderWidth = 0
        cancelButton.layer.borderColor = UIColor(rgb: 0x00487F).cgColor
        
        topView.layer.shadowOffset = CGSize(width: 0, height: 1)
        topView.layer.shadowOpacity = 0.05
        topView.layer.cornerRadius = 8
        topView.layer.shadowRadius = 3
        topView.layer.shadowColor = UIColor(rgb: 0x0090FF).cgColor
        topView.layer.masksToBounds = true
        topView.layer.borderWidth = 1
        topView.layer.borderColor = UIColor(rgb: 0x00487F).cgColor
        
        bottomView.layer.shadowOffset = CGSize(width: 0, height: 1)
        bottomView.layer.shadowOpacity = 0.05
        bottomView.layer.cornerRadius = 8
        bottomView.layer.shadowRadius = 3
        bottomView.layer.shadowColor = UIColor(rgb: 0x0090FF).cgColor
        bottomView.layer.masksToBounds = true
        bottomView.layer.borderWidth = 1
        bottomView.layer.borderColor = UIColor(rgb: 0x00487F).cgColor
        
    }
    
    //Dismiss Keyboard
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //Start up
    func formatInputFields(){
        if UserMetricsService.userMetricsArray.count != 0{
            bodyPartSegmentedControl.selectedSegmentIndex = UserMetricsService.userMetricsArray[0].bodyPart
            workoutTypeSegmentControl.selectedSegmentIndex = UserMetricsService.userMetricsArray[0].workoutType
            numberOfWeeksLabel.text = String(weekSlider.value)
            goalSegmentedControl.selectedSegmentIndex = UserMetricsService.userMetricsArray[0].goal
            volumeSegmentedControl.selectedSegmentIndex = UserMetricsService.userMetricsArray[0].volume
            weekSlider.setValue(Float(UserMetricsService.userMetricsArray[0].numberOfWeeks), animated: true)
            lengthOfWorkoutSlider.setValue(Float(UserMetricsService.userMetricsArray[0].lengthOfWorkout), animated: true)
            lengthOfWorkoutLabel.text = String(lengthOfWorkoutSlider.value)
        } else {
            bodyPartSegmentedControl.selectedSegmentIndex = -1
            workoutTypeSegmentControl.selectedSegmentIndex = 0
            goalSegmentedControl.selectedSegmentIndex = 1
            volumeSegmentedControl.selectedSegmentIndex = 1
            weekSlider.setValue(Float(1), animated: true)
            numberOfWeeksLabel.text = String(weekSlider.value)
            lengthOfWorkoutSlider.setValue(Float(45.0), animated: true)
            lengthOfWorkoutLabel.text = String(lengthOfWorkoutSlider.value)
        }
        
        //Labels
        numberOfWeeksLabel.text = "\(Int(weekSlider.value.rounded())) Weeks"
        lengthOfWorkoutLabel.text = "\(Int(lengthOfWorkoutSlider.value.rounded())) Minutes"
        
        
        //Date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM-dd-yyyy"
        txtDatePicker.text = formatter.string(from: CalendarViewController.selectedDateVar)
        showDatePicker()
        UserMetricsViewController.datePicker.date = CalendarViewController.selectedDateVar
        
        //Check Boxes
        if bodyPartSegmentedControl.selectedSegmentIndex != -1{
            switch bodyPartSegmentedControl.selectedSegmentIndex{
            case 0: selectionOfWorkoutTypesArray = ListOfExercises.listOfExeciseTypes.filter {$0 == ExerciseModel.BodyPart.chest.rawValue || $0 == ExerciseModel.BodyPart.back.rawValue || $0 == ExerciseModel.BodyPart.bicep.rawValue || $0 == ExerciseModel.BodyPart.tricep.rawValue || $0 == ExerciseModel.BodyPart.delt.rawValue}
            case 1: selectionOfWorkoutTypesArray = ListOfExercises.listOfExeciseTypes.filter {$0 == ExerciseModel.BodyPart.quads.rawValue || $0 == ExerciseModel.BodyPart.hamstrings.rawValue || $0 == ExerciseModel.BodyPart.calves.rawValue || $0 == ExerciseModel.BodyPart.olympicLifts.rawValue}
            case 2: selectionOfWorkoutTypesArray = ListOfExercises.listOfExeciseTypes
            default: fatalError("Index out of range")
            }
        } else {
            switch workoutTypeSegmentControl.selectedSegmentIndex{
            case 0: selectionOfWorkoutTypesArray = ListOfExercises.listOfExeciseTypes
            case 1: selectionOfWorkoutTypesArray = ListOfExercises.listOfExeciseTypes.filter {$0 == ExerciseModel.BodyPart.cardio.rawValue}
            case 2: selectionOfWorkoutTypesArray = ListOfExercises.listOfExeciseTypes.filter {$0 != ExerciseModel.BodyPart.cardio.rawValue}
            default: fatalError("Index out of range")
            }
        }
        clickedArray = []
        UserMetricsViewController.clickedWorkoutsArray = selectionOfWorkoutTypesArray
        if UserMetricsService.userMetricsArray.count != 0{
            clickedArray = UserMetricsService.userMetricsArray[0].checked
        } else {
            for _ in UserMetricsViewController.clickedWorkoutsArray {
                clickedArray.append(1)
            }
        }
        var counterMetric = 0
        var holdArray = [String]()
        for check in UserMetricsViewController.clickedWorkoutsArray{
            if clickedArray[counterMetric] == 1{
                holdArray.append(check)
            }
            counterMetric += 1
        }
        UserMetricsViewController.clickedWorkoutsArray = holdArray
        
        
        exerciseSelectorTableView.reloadData()
        
    }
    
    //Saving User Metrics
    func updateMetrics(){
        if UserMetricsService.userMetricsArray.count != 0{
            
            //                    UserMetricsService.updateUserMetrics(weight: Int(weightTextField.text!)!, height: Int(heightTextField.text!)!, age: Int(ageTextField.text!)!, gender: Int(genderTextField.text!)!, date: CalendarViewController.selectedDateVarString, goal: goalSegmentedControl.selectedSegmentIndex, bodyPart: bodyPartSegmentedControl.selectedSegmentIndex, workoutType: workoutTypeSegmentControl.selectedSegmentIndex,volume: Int(volumeSegmentedControl.selectedSegmentIndex), lengthOfWorkout: Int(lengthOfWorkoutSlider.value.rounded()), numberOfWeeks: Int(weekSlider.value.rounded()))
            UserMetricsService.updateUserMetrics(weight: 0, height: 0, age: 0, gender: 0, date: CalendarViewController.selectedDateVarString, goal: goalSegmentedControl.selectedSegmentIndex, bodyPart: bodyPartSegmentedControl.selectedSegmentIndex, workoutType: workoutTypeSegmentControl.selectedSegmentIndex, checked: clickedArray,volume: Int(volumeSegmentedControl.selectedSegmentIndex), lengthOfWorkout: Int(lengthOfWorkoutSlider.value.rounded()), numberOfWeeks: Int(weekSlider.value.rounded()))
            
            
            
            return
            
            
        } else {
            
            //            UserMetricsService.writeUserMetrics(weight: Int(weightTextField.text!)!, height: Int(heightTextField.text!)!, age: Int(ageTextField.text!)!, gender: Int(genderTextField.text!)!, date: CalendarViewController.selectedDateVarString, goal: goalSegmentedControl.selectedSegmentIndex, bodyPart: bodyPartSegmentedControl.selectedSegmentIndex, workoutType: workoutTypeSegmentControl.selectedSegmentIndex,volume: Int(volumeSegmentedControl.selectedSegmentIndex), lengthOfWorkout: Int(lengthOfWorkoutSlider.value.rounded()), numberOfWeeks: Int(weekSlider.value.rounded()))
            
            UserMetricsService.writeUserMetrics(weight: 0, height: 0, age: 0, gender: 0, date: CalendarViewController.selectedDateVarString, goal: goalSegmentedControl.selectedSegmentIndex, bodyPart: bodyPartSegmentedControl.selectedSegmentIndex, workoutType: workoutTypeSegmentControl.selectedSegmentIndex, checked: clickedArray,volume: Int(volumeSegmentedControl.selectedSegmentIndex), lengthOfWorkout: Int(lengthOfWorkoutSlider.value.rounded()), numberOfWeeks: Int(weekSlider.value.rounded()))
        }
        
        UserMetricsService.userMetricsArray[0].checked = clickedArray
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
        
        updateButton.isUserInteractionEnabled = false
        
        WorkoutService.deleteSectionSender = "UserMetrics"
        
        UserMetricsViewController.dateTracker = UserMetricsViewController.datePicker.date
        
        
        
        
        //Deleting old workouts
        
        for _ in 1...Int(self.weekSlider.value*(7)){
            
            for workout in WorkoutService.workoutArray {
                
                if workout.dateCreated == UserMetricsViewController.dateTracker.toString(dateFormat: "MMM-dd-yyyy"){
                    
                    WorkoutService.removeWorkout(exerciseName: workout.dateCreated, numberOfReps: workout.numberOfReps, numberOfSets: workout.numberOfReps, weight: workout.weight, completed: workout.completed, sectionNumber: workout.sectionNumber, alreadyAdded: workout.alreadyAdded, dateCreated: workout.dateCreated, bodyPart: workout.bodyPart, restDays: workout.restDays, intensity: workout.intensity, workoutType: workout.workoutType)
                    
                    //                    WorkoutService.workoutArray.remove(at: WorkoutService.workoutArray.index(where: {$0 === workout})!)
                    WODViewController.copiedVariable.remove(at: WODViewController.copiedVariable.index(where: {$0 === workout})!)
                }
                
            }
            
            UserMetricsViewController.dateTracker = Calendar.current.date(byAdding: .day, value: 1, to: UserMetricsViewController.dateTracker)!
            
        }
        
        
        
        //Writing new Workout
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            
            //MARK: USER METRICS TO WORKOUT CALCULATOR
            
            
            //FILTER BASED ON SELECTED BODY PARTS OR WORKOUT TYPE ADD HERE:
            
            
            self.selectedBodyPartArray = self.listOfExercises
            self.selectedBodyPartArray = self.selectedBodyPartArray.filter {UserMetricsViewController.clickedWorkoutsArray.contains($0.bodyPart)}
            
            
            
            
            ///////////////////////////////////////////////
            
            
            var numberOfExercises = 0
            switch self.lengthOfWorkoutSlider.value {
                
            case let x where x >= 0 && x < 16: numberOfExercises = 1
            case let x where x >= 15 && x < 31: numberOfExercises = 2
            case let x where x >= 30 && x < 46: numberOfExercises = 3
            case let x where x >= 45 && x < 61: numberOfExercises = 4
            case let x where x >= 60 && x < 76: numberOfExercises = 5
            case let x where x >= 75 && x < 91: numberOfExercises = 6
            case let x where x >= 90 && x < 106: numberOfExercises = 7
            case let x where x >= 105 && x < 121: numberOfExercises = 8
            default: fatalError("Out of range")
                
            }
            
            
            
            //END
            
            
            
            var numberOfReps = 0
            var numberOfSets = 0
            var formattedDate = UserMetricsViewController.datePicker.date.toString(dateFormat: "MMM-dd-yyyy")
            
            UserMetricsViewController.dateTracker = UserMetricsViewController.datePicker.date
            self.selectedExercise = self.listOfExercises[0]
            WorkoutService.currentSectionNumber = "0"
            
            for _ in 1...Int(self.weekSlider.value*(7)){
                
                WorkoutService.currentSectionNumber = "0"
                
                formattedDate = UserMetricsViewController.dateTracker.toString(dateFormat: "MMM-dd-yyyy")
                
                let holdArray = self.selectedBodyPartArray
                
                for _ in 1...numberOfExercises{
                    
                    if self.selectedBodyPartArray.count == 0{
                        self.selectedBodyPartArray = holdArray
                    }
                    
                    self.selectedExercise = self.selectedBodyPartArray[Int(arc4random_uniform(UInt32(self.selectedBodyPartArray.count)))]
                    
                    switch self.goalSegmentedControl.selectedSegmentIndex {
                        
                    case 0: numberOfReps = self.selectedExercise.numberOfReps[0]
                    numberOfSets = self.selectedExercise.numberOfSets[0]
                    case 1: numberOfReps = self.selectedExercise.numberOfReps[1]
                    numberOfSets = self.selectedExercise.numberOfSets[1]
                    case 2: numberOfReps = self.selectedExercise.numberOfReps[2]
                    numberOfSets = self.selectedExercise.numberOfSets[2]
                    case 3: numberOfReps = self.selectedExercise.numberOfReps[3]
                    numberOfSets = self.selectedExercise.numberOfSets[3]
                    default: fatalError("Out of Range")
                        
                    }
                    
                    self.selectedExercise.numberOfReps = []
                    self.selectedExercise.weight = []
                    self.selectedExercise.completed = []
                    for _ in 1...numberOfSets {
                        self.selectedExercise.numberOfReps.append(numberOfReps)
                        self.selectedExercise.weight.append(0)
                        self.selectedExercise.completed.append(0)
                    }
                    
                    
                    WorkoutService.writeProgram(exerciseName: self.selectedExercise.exerciseName, numberOfReps: self.selectedExercise.numberOfReps, numberOfSets: [numberOfSets], weight: self.selectedExercise.weight, completed: self.selectedExercise.completed,sectionNumber: Int(WorkoutService.currentSectionNumber)!, alreadyAdded: true, dateCreated: formattedDate, bodyPart: self.selectedExercise.bodyPart, restDays: self.selectedExercise.restDays,intensity: self.selectedExercise.intensity, workoutType: self.selectedExercise.workoutType)
                    
                    WorkoutService.currentSectionNumber = String(Int(WorkoutService.currentSectionNumber)!+1)
                    
                    self.selectedBodyPartArray.remove(at: self.selectedBodyPartArray.index(where: {$0 === self.selectedExercise})!)
                }
                
                UserMetricsViewController.dateTracker = Calendar.current.date(byAdding: .day, value: 1, to: UserMetricsViewController.dateTracker)!
                self.selectedBodyPartArray = holdArray
            }
            
            WODViewController.copyOverData()
            self.updateButton.isUserInteractionEnabled = true
            
        }
        
        
    }
}


//Exercise selector Table View
extension UserMetricsViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectionOfWorkoutTypesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseSelectorCell", for: indexPath) as! ExerciseSelectorCell
        cell.delegate = self as ExerciseSelectorCellDelegate
        cell.exerciseName.text = selectionOfWorkoutTypesArray[indexPath.row]
        configureCell(cell: cell, forIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: ExerciseSelectorCell, forIndexPath indexPath: IndexPath){
        
        cell.checkBox.borderStyle = .circle
        cell.checkBox.checkmarkStyle = .tick
        cell.checkBox.checkmarkColor = .blue
        cell.checkBox.checkedBorderColor = .blue
        cell.checkBox.uncheckedBorderColor = .black
        
        if clickedArray[indexPath.row] == 1{
            cell.checkBox.isChecked = true
        } else {
            cell.checkBox.isChecked = false
        }
        
        cell.checkBox.addTarget(cell, action: #selector(cell.checkboxValueChanged(sender:)), for: .valueChanged)
        
    }
    
    
}

//Check Box
extension UserMetricsViewController: ExerciseSelectorCellDelegate{
    
    func selectingExerciseTypes(cell: ExerciseSelectorCell, checked: Bool) {
        
        let indexPath = exerciseSelectorTableView.indexPath(for: cell)!
        if checked == true{
            if UserMetricsViewController.clickedWorkoutsArray.count != 1 || UserMetricsViewController.clickedWorkoutsArray[0] != cell.exerciseName.text!{
                UserMetricsViewController.clickedWorkoutsArray.append(cell.exerciseName.text!)
                clickedArray[indexPath.row] = 1
            }
            
        } else {
            if UserMetricsViewController.clickedWorkoutsArray.count > 1{
                UserMetricsViewController.clickedWorkoutsArray.remove(at: UserMetricsViewController.clickedWorkoutsArray.index(of: UserMetricsViewController.clickedWorkoutsArray.filter {$0 == cell.exerciseName.text!}[0])!)
                clickedArray[indexPath.row] = 0
            }
        }
        
    }
    
    
}

