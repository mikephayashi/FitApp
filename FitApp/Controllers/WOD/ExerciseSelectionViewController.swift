
//  ExerciseSelectionViewController.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/23/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit

class ExerciseSelectionViewController: UIViewController{
    
    @IBOutlet weak var listOfExercisesTableView: UITableView!
    
    let listOfExercisesReference = ListOfExercises()
    var listOfExercises = [ExerciseModel]()
    var selectedCell = IndexPath()
    
    override func viewWillAppear(_ animated: Bool) {
        listOfExercises = listOfExercisesReference.listOfExercises
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier{
        
        case "newExercise":
            let destination = segue.destination as! WODViewController
            let indexPath = listOfExercisesTableView.indexPathForSelectedRow
            
//            destination.selectedExercise = destination.listOfExercises[indexPath!.row]
            destination.selectedExercise = destination.listOfExercises.filter {$0.exerciseName == (listOfExercisesTableView.cellForRow(at: indexPath!) as! ExerciseNameCell).exerciseNameLabel.text}[0]
            destination.formatTableView()
            
            
            
        case "cancelExercise": return
        default: return
            
        }
        
    }
    
    
}

extension ExerciseSelectionViewController: UITableViewDataSource {
    
    //TableViews
    func numberOfSections(in tableView: UITableView) -> Int {

        return 11
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        switch section {
        case 0: return "Chest"
        case 1: return "Back"
        case 2: return "Biceps"
        case 3: return "Triceps"
        case 4: return "Delts"
        case 5: return "Abs"
        case 6: return "Quads"
        case 7: return "Hamstrings"
        case 8: return "Calves"
        case 9: return "Cardio"
        case 10: return "Olympic Lifts"
        default:
            return "??"
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let array = listOfExercises.filter {$0.bodyPart == self.tableView(listOfExercisesTableView, titleForHeaderInSection: section)}
        return array.count

        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseNameCell", for: indexPath) as! ExerciseNameCell
        configureCell(cell: cell, forIndexPath: indexPath)
        return cell
        
    }
    
    func configureCell(cell: ExerciseNameCell, forIndexPath indexPath: IndexPath){
        
        
        cell.exerciseNameLabel.text = listOfExercises[indexPath.row].exerciseName
        
        let array = listOfExercises.filter {$0.bodyPart == self.tableView(listOfExercisesTableView, titleForHeaderInSection: indexPath.section)}
        cell.exerciseNameLabel.text = array[indexPath.row].exerciseName
    }
    

    
}

