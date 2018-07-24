
//  ExerciseSelectionViewController.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/23/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit

class ExerciseSelection: UIViewController{
    
    @IBOutlet weak var listOfExercisesTableView: UITableView!
    
    let listOfExercisesReference = ListOfExercises()
    var listOfExercises = [Exercise]()
    
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
        
        let destination = segue.destination as! TodaysWorkoutViewController
        let indexPath = listOfExercisesTableView.indexPathForSelectedRow
        
        destination.exerciseSelectionIndexPath = indexPath
        destination.formatTableView()
        
    }
    
}

extension ExerciseSelection: UITableViewDataSource {
    
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
