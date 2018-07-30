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
    
    
    //Overide Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
            weekSlider.setValue(Float(UserMetricsService.userMetricsArray[0].numberOfWeeks), animated: true)
            numberOfWeeksLabel.text = String(weekSlider.value)
        } else {
            weightTextField.text = String(0)
            heightTextField.text = String(0)
            ageTextField.text = String(0)
            genderTextField.text = String(0)
            goalSegmentedControl.selectedSegmentIndex = 0
            bodyPartSegmentedControl.selectedSegmentIndex = 0
            weekSlider.setValue(Float(0), animated: true)
            numberOfWeeksLabel.text = String(weekSlider.value)
        }
        
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
    
    @IBAction func weekSliderTapped(_ sender: Any) {
        numberOfWeeksLabel.text = "\(weekSlider.value.rounded()) Weeks"
        updateMetrics()
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
                    UserMetricsService.updateUserMetrics(weight: Int(weightTextField.text!)!, height: Int(heightTextField.text!)!, age: Int(ageTextField.text!)!, gender: Int(genderTextField.text!)!, date: CalendarViewController.selectedDateVarString, goal: goalSegmentedControl.selectedSegmentIndex, bodyPart: bodyPartSegmentedControl.selectedSegmentIndex, numberOfWeeks: Int(weekSlider.value.rounded()))
                    
                    print("Date Exists")
                    
                    return
                    
                } else {
                    
                    UserMetricsService.writeUserMetrics(weight: Int(weightTextField.text!)!, height: Int(heightTextField.text!)!, age: Int(ageTextField.text!)!, gender: Int(genderTextField.text!)!, date: CalendarViewController.selectedDateVarString, goal: goalSegmentedControl.selectedSegmentIndex, bodyPart: bodyPartSegmentedControl.selectedSegmentIndex, numberOfWeeks: Int(weekSlider.value.rounded()))
                    
                    print("Date Exists Not")
                    
                    return
                }
            }
            
        } else {
            
            UserMetricsService.writeUserMetrics(weight: Int(weightTextField.text!)!, height: Int(heightTextField.text!)!, age: Int(ageTextField.text!)!, gender: Int(genderTextField.text!)!, date: CalendarViewController.selectedDateVarString, goal: goalSegmentedControl.selectedSegmentIndex, bodyPart: bodyPartSegmentedControl.selectedSegmentIndex, numberOfWeeks: Int(weekSlider.value.rounded()))
        }
    }
    
}


