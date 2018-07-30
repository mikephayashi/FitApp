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
    
    //IBActions
    @IBAction func updateUserMetricsTapped(_ sender: Any) {
        
        if UserMetricsService.userMetricsArray.count != 0 {
            for metric in UserMetricsService.userMetricsArray{
                //                checkMetrics()
                
                if CalendarViewController.selectedDateVarString == metric.date{
                    UserMetricsService.updateUserMetrics(weight: Int(weightTextField.text!)!, height: Int(heightTextField.text!)!, age: Int(ageTextField.text!)!, gender: Int(genderTextField.text!)!, date: CalendarViewController.selectedDateVarString)
                    
                    print("Date Exists")
                    
                    return
                    
                } else {
                    
                    UserMetricsService.writeUserMetrics(weight: Int(weightTextField.text!)!, height: Int(heightTextField.text!)!, age: Int(ageTextField.text!)!, gender: Int(genderTextField.text!)!, date: CalendarViewController.selectedDateVarString)
                    
                    print("Date Exists Not")
                    
                    return
                }
            }
            
        } else {
            
            UserMetricsService.writeUserMetrics(weight: Int(weightTextField.text!)!, height: Int(heightTextField.text!)!, age: Int(ageTextField.text!)!, gender: Int(genderTextField.text!)!, date: CalendarViewController.selectedDateVarString)
        }
        
    }
    
    //Dismiss Keyboard
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
}


