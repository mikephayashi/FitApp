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
    var selectedExercise = Exercise(exerciseName: "", numberOfReps: [], numberOfSets: [], sectionNumber: 0, alreadyAdded: false)
    var listOfSelectedExercises = [Exercise]()
    
    //Adding Set Cell Index Path
    var selectedIndexPath: IndexPath!
    
    //Exercise Selection IndexPath
    var exerciseSelectionIndexPath: IndexPath!
    
    //List of Exercises
    let listOfExercisesReference = ListOfExercises()
    var listOfExercises = [Exercise]()
    
    //Timer
    @IBOutlet weak var toggleTimerButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var timerProgressView: UIProgressView!
    
    var timerLength = 60
    var savedTime = 60
    var timerIsRunning = false
    
    var countDownTimer = Timer()
    
    //Test Variables
    var weightInput = 1
    var heightInput = 1
    var ageInput = 1
    var genderInput = 1
    
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
    
    @IBAction func unwindWithSegueToHome(_ segue: UIStoryboardSegue){

    }

    
    //Setting Table View
    func checkDuplicates(){
        
        selectedExercise = listOfExercises[exerciseSelectionIndexPath.row]
        
        if listOfSelectedExercises.count == 0{
            formatTableView()
            return
        }
        
        //check this
        
        for exercise in listOfSelectedExercises {
            if selectedExercise.alreadyAdded == false && selectedExercise.exerciseName != exercise.exerciseName{
                formatTableView()
            }
        }
        

    }
    
    func formatTableView(){
        
        //No sections on loading
        selectedExercise.sectionNumber = exerciseListTableView.numberOfSections
        selectedExercise.numberOfSets.append(1)
        selectedExercise.alreadyAdded = true
        
        listOfSelectedExercises.append(selectedExercise)
        exerciseListTableView.reloadData()
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
}


extension WODViewController: UITableViewDataSource{
    
    
    //TableViews
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var returnedValue = 0
        
        if listOfSelectedExercises.count != 0{
            returnedValue = listOfSelectedExercises.count
        }
        
        return returnedValue
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var valuedReturned = ""
        if listOfSelectedExercises.count != 0{
            
            valuedReturned = listOfSelectedExercises[section].exerciseName
        }
        return valuedReturned
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnedValue = 0
        if listOfSelectedExercises.count != 0{
            for x in listOfSelectedExercises {
                if x.sectionNumber == section {
                    returnedValue = 3 + x.numberOfSets[0]
                }
            }
        }
        
        return returnedValue
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnedValue = tableView.dequeueReusableCell(withIdentifier: "ExerciseHeaderCell", for: indexPath)
        if listOfSelectedExercises.count != 0 {
            for exercise in listOfSelectedExercises {
                if exercise.sectionNumber == indexPath.section{
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
        
        return returnedValue
        
    }
    
}


extension WODViewController: AddingSetCellDelegate{
    
    func reloadingNumberOfSets(cell: AddingSetCell) {
        
        let indexPath = exerciseListTableView.indexPath(for: cell)!
        
        for x in listOfSelectedExercises{
            if indexPath.section == x.sectionNumber{
                listOfSelectedExercises[x.sectionNumber].numberOfSets[0] += 1
                exerciseListTableView.reloadData()
            }
        }
    }
}









