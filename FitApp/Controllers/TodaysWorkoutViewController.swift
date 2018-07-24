//
//  ViewController.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/23/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit

class TodaysWorkoutViewController: UIViewController {
    
    //Objects
    @IBOutlet weak var newExerciseButton: UIButton!
    @IBOutlet weak var exerciseListTableView: UITableView!
    
    //Exercise Properties
    var selectedExercise: Exercise!
    var sectionNumber = 0
    var listOfSelectedExercises = [Exercise]()
    
    //Adding Set Cell Index Path
    var selectedIndexPath: IndexPath!
    
    //Exercise Selection IndexPath
    var exerciseSelectionIndexPath: IndexPath!
    
    //List of Exercises
    let listOfExercisesReference = ListOfExercises()
    var listOfExercises = [Exercise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listOfExercises = listOfExercisesReference.listOfExercises
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newExerciseTapped(_ sender: Any) {
        
    }
    
    @IBAction func unwindWithSegueToHome(_ segue: UIStoryboardSegue){
        
    }
    
    func formatTableView(){
        print("New Exercise")

        selectedExercise = listOfExercises[exerciseSelectionIndexPath.row]
        selectedExercise.sectionNumber = sectionNumber
        selectedExercise.numberOfSets.append(1)
        print("Selected Exercise: \(selectedExercise.exerciseName)")
        
        sectionNumber = selectedExercise.sectionNumber
        sectionNumber += 1
        
        listOfSelectedExercises.append(selectedExercise)
        exerciseListTableView.reloadData()
    }
    
}

extension TodaysWorkoutViewController: UITableViewDataSource{
    
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
            print("Section: \(section)")
            print(listOfSelectedExercises[section].exerciseName)
            for x in listOfSelectedExercises{
                print(x.exerciseName)
            }
            valuedReturned = listOfSelectedExercises[section].exerciseName
        }
        return valuedReturned
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnedValue = 0
        if listOfSelectedExercises.count != 0{
            for x in listOfSelectedExercises {
                if x.sectionNumber == section {
                    print("Rows")
                    returnedValue = 3 + x.numberOfSets[0]
                }
            }
        }
        
        return returnedValue
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("list of selected exercises")
        print(listOfSelectedExercises)
        var returnedValue = tableView.dequeueReusableCell(withIdentifier: "ExerciseHeaderCell", for: indexPath) 
        if listOfSelectedExercises.count != 0 {
            print("list of selected exercises not 0")
            for x in listOfSelectedExercises {
//                if x.sectionNumber == indexPath.section {
                    switch  indexPath.row {
                    case 0:
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseHeaderCell", for: indexPath) as! ExerciseHeaderCell
                        print("Cell 0")
                        returnedValue = cell
                    case 1:
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseLabelsCell", for: indexPath) as! ExerciseLabelsCell
                        print("Cell 1")
                        returnedValue = cell
                    // + 2 because middle = 2 + numberOfSets
                    case let x where x > 1 && x < selectedExercise.numberOfSets[0] + 2 :
                        let cell = tableView.dequeueReusableCell(withIdentifier: "SetDataCell", for: indexPath) as! SetDataCell
                        print("Cell Middle")
                        returnedValue = cell
                    case selectedExercise.numberOfSets[0]+2:
                        let cell = tableView.dequeueReusableCell(withIdentifier: "AddingSetCell", for: indexPath) as! AddingSetCell
                        cell.delegate = self as AddingSetCellDelegate
                        print("Cell End")
                        returnedValue = cell
                    default:
                        fatalError("Error unexpected Indexpath.row")
                    }
//                }
            }
        }
        
        return returnedValue
        
    }
    
}

extension TodaysWorkoutViewController: AddingSetCellDelegate{
    
    func reloadingNumberOfSets(cell: AddingSetCell) {
        
        let indexPath = exerciseListTableView.indexPath(for: cell)!

        print("index path: \(indexPath)")
        print(listOfSelectedExercises)
        print(listOfSelectedExercises)
        
        for x in listOfSelectedExercises{
            print(x.sectionNumber)
            if indexPath.section == x.sectionNumber{
                listOfSelectedExercises[sectionNumber].numberOfSets[0] += 1
                print("Rep Added")
                exerciseListTableView.reloadData()
            }
        }
    }
}









