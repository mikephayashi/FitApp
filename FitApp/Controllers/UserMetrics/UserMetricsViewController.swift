//
//  UserMetricsViewController.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/25/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit

protocol UserMetricsDelegate: class {
    func outputWorkouts(weight: Int, height: Int, age: Int, gender: Int)
}

class UserMetricsViewController: UIViewController {
    
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
    weak var delegate: UserMetricsDelegate?
    
    //Overide Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(tap)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
        let weightInput = Int(weightTextField.text!)!
        let heightInput = Int(heightTextField.text!)!
        var ageInput = Int(ageTextField.text!)!
        var genderInput = Int(genderTextField.text!)!
        
        TodaysWorkoutViewController().outputWorkouts(weight: weightInput, height: heightInput, age: ageInput, gender: genderInput)
//        CalculateUserMetrics().outputWorkouts(weight: weightInput, height: heightInput, age: ageInput, gender: genderInput)
//        TodaysWorkoutViewController().calculateWorkouts(weight: weightInput, height: heightInput, age: ageInput, gender: genderInput)
    }
    
    //Dismiss Keyboard
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" {
            let vc = segue.destination as! TodaysWorkoutViewController
            self.delegate = vc
        }
    }
    
    
}


