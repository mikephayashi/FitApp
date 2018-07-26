
//  ExerciseSelectionViewController.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/23/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit

class ExerciseSelectionViewController: UIViewController{
    
    @IBOutlet weak var listOfExercisesTableView: UITableView!
    @IBOutlet weak var exerciseSearchBar: UISearchBar!
    
    let listOfExercisesReference = ListOfExercises()
    var listOfExercises = [Exercise]()
    var selectedCell = IndexPath()
    
    override func viewWillAppear(_ animated: Bool) {
        listOfExercises = listOfExercisesReference.listOfExercises
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(tap)
        
        if exerciseSearchBar.isSearchResultsButtonSelected {
            print ("searched")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! TodaysWorkoutViewController
        let indexPath = listOfExercisesTableView.indexPathForSelectedRow
        
        destination.exerciseSelectionIndexPath = indexPath
        destination.checkDuplicates()
        
    }
    
    //Dismiss Keyboard
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}

extension ExerciseSelectionViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("This cell from the chat list was selected: \(indexPath.row)")
        selectedCell = indexPath
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return listOfExercises.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseNameCell", for: indexPath) as! ExerciseNameCell
        configureCell(cell: cell, forIndexPath: indexPath)
        return cell
        
    }
    
    func configureCell(cell: ExerciseNameCell, forIndexPath indexPath: IndexPath){
    
        cell.exerciseNameLabel.text = listOfExercises[indexPath.row].exerciseName
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
}

