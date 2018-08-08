
//  CalendarViewcontroller.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/23/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit
import VACalendar

final class CalendarViewController: UIViewController {
    
    static var selectedDateVar = Date()
    static var selectedDateVarString: String!
    
    @IBOutlet var workoutLabel: UILabel!
    @IBOutlet weak var calendarTableView: UITableView!
    
    
    
    @IBOutlet weak var monthHeaderView: VAMonthHeaderView! {
        didSet {
            let appereance = VAMonthHeaderViewAppearance(
                previousButtonImage: #imageLiteral(resourceName: "previous"),
                nextButtonImage: #imageLiteral(resourceName: "next"),
                dateFormat: "LLLL"
            )
            monthHeaderView.delegate = self
            monthHeaderView.appearance = appereance
        }
    }
    
    @IBOutlet var weekDaysView: VAWeekDaysView!{
        didSet {
            let appereance = VAWeekDaysViewAppearance(symbolsType: .veryShort, calendar: defaultCalendar)
            weekDaysView.appearance = appereance
        }
    }
    
    let defaultCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        calendar.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())!
        return calendar
    }()
    
    var calendarView: VACalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //remove separators for empty cells
        calendarTableView.tableFooterView = UIView()
        //remove separators from cells
        calendarTableView.separatorStyle = .none
        //remove scroll
        calendarTableView.showsVerticalScrollIndicator = false
        
        let calendar = VACalendar(calendar: defaultCalendar)
        calendarView = VACalendarView(frame: .zero, calendar: calendar)
        calendarView.showDaysOut = true
        calendarView.selectionStyle = .single  //Number of days selected
        calendarView.monthDelegate = monthHeaderView
        calendarView.dayViewAppearanceDelegate = self
        calendarView.monthViewAppearanceDelegate = self
        calendarView.calendarDelegate = self
        calendarView.scrollDirection = .horizontal
        //Bottom Dots
        //        calendarView.setSupplementaries([
        //            (Date().addingTimeInterval(-(60 * 60 * 70)), [VADaySupplementary.bottomDots([.red, .magenta])]),
        //            (Date().addingTimeInterval((60 * 60 * 110)), [VADaySupplementary.bottomDots([.red])]),
        //            (Date().addingTimeInterval((60 * 60 * 370)), [VADaySupplementary.bottomDots([.blue, .darkGray])]),
        //            (Date().addingTimeInterval((60 * 60 * 430)), [VADaySupplementary.bottomDots([.orange, .purple, .cyan])])
        //            ])
        calendarView.setSupplementaries([
            (Date(), [VADaySupplementary.bottomDots([.red])])
            ])
        view.addSubview(calendarView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //        calendarView.setup()
        calendarView.setupSelection()
        calendarView.selectDates([CalendarViewController.selectedDateVar])
        calendarTableView.reloadData()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if calendarView.frame == .zero {
            calendarView.frame = CGRect(
                x: 0,
                y: weekDaysView.frame.maxY,
                width: view.frame.width,
                height: view.frame.height * 0.4 //Changing height of month calendar
            )
            calendarView.setup()
        }
    }
    
    @IBAction func changeMode(_ sender: Any) {
        calendarView.changeViewType()
    }
    
}

extension CalendarViewController: VAMonthHeaderViewDelegate {
    
    func didTapNextMonth() {
        calendarView.nextMonth()
    }
    
    func didTapPreviousMonth() {
        calendarView.previousMonth()
    }
    
}

extension CalendarViewController: VAMonthViewAppearanceDelegate {
    
    func leftInset() -> CGFloat {
        return 10.0
    }
    
    func rightInset() -> CGFloat {
        return 10.0
    }
    
    func verticalMonthTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    func verticalMonthTitleColor() -> UIColor {
        return .black
    }
    
    func verticalCurrentMonthTitleColor() -> UIColor {
        return .red
    }
    
    
}

extension CalendarViewController: VADayViewAppearanceDelegate {
    
    func textColor(for state: VADayState) -> UIColor {
        switch state {
        case .out:
            return UIColor(red: 214 / 255, green: 214 / 255, blue: 219 / 255, alpha: 1.0)
        case .selected:
            return .white
        case .unavailable:
            return .clear
        default:
            return .black
        }
        
    }
    
    func textBackgroundColor(for state: VADayState, day: Date, label: UILabel) -> UIColor {
        
        switch state {
        case .selected:
            return UIColor(rgb: 0x4CB1FF)
        default:
            var returnedColor = UIColor.clear
            if WorkoutService.listOfDatesArray.contains(day.toString(dateFormat: "MMM-dd-yyyy")){
                if state == .available{
                label.clipsToBounds = true
                label.layer.cornerRadius = label.frame.height / 2
                label.textColor = .white
                returnedColor = UIColor.gray
                }
                return returnedColor
            } else {
                return .clear
            }
        }
    }
    
    func shape() -> VADayShape {
        
        return .circle
    }
    
    func dotBottomVerticalOffset(for state: VADayState) -> CGFloat {
        switch state {
        case .selected:
            return 2
        default:
            return -7
        }
    }
    
}

extension CalendarViewController: VACalendarViewDelegate {
    
    //Change to "selectedDates" for multiple selection
    func selectedDate(_ date: Date) {
        CalendarViewController.selectedDateVar = date
        UserMetricsViewController.datePicker.date = date
        CalendarViewController.selectedDateVarString = date.toString(dateFormat: "MMM-dd-yyyy")
        WorkoutService.deleteSectionSender = "WOD"
        calendarTableView.reloadData()
        
    }
    
    
    
}

extension CalendarViewController: UITableViewDataSource{
    
    //TableViews
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return CalendarViewController.selectedDateVarString
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return WorkoutService.workoutArray.filter {$0.dateCreated == CalendarViewController.selectedDateVarString}.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WODTableViewCell", for: indexPath) as! WODTableViewCell
        configureCell(cell: cell, forIndexPath: indexPath)
        return cell
        
    }
    
    func configureCell(cell: WODTableViewCell, forIndexPath indexPath: IndexPath){
        
        let day = WorkoutService.workoutArray.filter {$0.dateCreated == CalendarViewController.selectedDateVarString}[indexPath.row]
        cell.workoutLabel.text = "\(day.exerciseName) - Sets: \(day.numberOfSets[0]) X Reps: \(day.numberOfReps)"
        cell.workoutLabel.adjustsFontSizeToFitWidth = true
        
        
    }
    
}

