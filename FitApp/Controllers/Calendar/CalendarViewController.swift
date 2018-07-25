
//  CalendarViewcontroller.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/23/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarMenuView: JTSCalendarMenuView!
    @IBOutlet weak var calendarContentView: JTSHorizontalCalendarView!
    @IBOutlet weak var calendarContentViewHeight: NSLayoutConstraint!
    
    
    var calendarManager:JTSCalendarManager?
    
    var monthSwiped: Date?
    
//    private var _eventsByDate:[String:[Date]]?
    private var _todayDate:Date?
    private var _minDate:Date?
    private var _maxDate:Date?
    private var _dateSelected:Date? //Date Clicked
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        title = "Basic"
    }
    
    //App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarManager = JTSCalendarManager()
        calendarManager?.delegate = self
//        createRandomEvents()
        createMinAndMaxDate()
        calendarManager?.menuView = calendarMenuView
        calendarManager?.contentView = calendarContentView
        calendarManager?.setDate(_todayDate!)
        // Do any additional setup after loading the view.
        
        calendarMenuView.isUserInteractionEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Buttons Clicked
    @IBAction func didGoTodayTouch(_ sender: UIButton) {
        calendarManager?.setDate(_todayDate!)
    }
    
    @IBAction func didChangeModeTouch(_ sender: UIButton) {
        calendarManager?.settings?.isWeekModeEnabled = !(calendarManager?.settings?.isWeekModeEnabled)!
        calendarManager?.reload()
        var newHeight:CGFloat = 300.0
        if (calendarManager?.settings?.isWeekModeEnabled)! {
            newHeight = 85.0
        }
        UIView.transition(with: self.view, duration: 0.5, options: [], animations: {
            self.calendarContentViewHeight.constant = newHeight
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
   
    @IBAction func lastMonthClicked(_ sender: Any) {
//        JTSHorizontalCalendarView.loadPreviousPage(calendarContentView)
    }
    
    @IBAction func nextMonthClicked(_ sender: Any) {
        
    }
    
    
    
    //Months Available
    func createMinAndMaxDate() {
        _todayDate = Date()

        // Min date will be 2 month before today
        _minDate = calendarManager?.dateHelper?.addToDate(_todayDate!, months: -2)
        // Max date will be 2 month after today
        _maxDate = calendarManager?.dateHelper?.addToDate(_todayDate!, months: 2)
    }
    
    // Used only to have a key for _eventsByDate
    func dateFormatter() -> DateFormatter {
        var dateFormatter: DateFormatter?
        if dateFormatter == nil {
            dateFormatter = DateFormatter()
            dateFormatter?.dateFormat = "yyyy-MM-dd"
        }
        return dateFormatter!
    }
    
    //Event
//    func haveEvent(forDay date: Date) -> Bool {
//        let key: String = dateFormatter().string(from: date)
//        if _eventsByDate![key] != nil && (_eventsByDate![key]?.count)! > 0 {
//            return true
//        }
//        return false
//    }
    
    //Random Events
//    func createRandomEvents() {
//        _eventsByDate = [String: [Date]]()
//        for _ in 0..<30 {
//            // Generate 30 random dates between now and 60 days later
//            let randomDate = Date(timeInterval: TimeInterval(arc4random() % (3600 * 24 * 60)), since: Date())
//            // Use the date as key for eventsByDate
//            let key: String = dateFormatter().string(from: randomDate)
//            if !(_eventsByDate![key] != nil) {
//                _eventsByDate![key] = [Date]()
//            }
//            _eventsByDate![key]?.append(randomDate)
//        }
//    }
    
}

extension CalendarViewController:JTSCalendarDelegate{
    
    //Prepares Day Views
    func calendar(_ calendar: JTSCalendarManager, prepareDayView dayView: JTSCalendarDayView) {
        // Today
        if (calendarManager?.dateHelper?.isTheSameDayThan(Date(), dayView.date!))! {
            dayView.circleView?.isHidden = false
            dayView.circleView?.backgroundColor = UIColor.blue
            dayView.dotView?.backgroundColor = UIColor.white
            dayView.textLabel?.textColor = UIColor.white
        }
        else if _dateSelected != nil && (calendarManager?.dateHelper?.isTheSameDayThan(_dateSelected!, dayView.date!))! {
            dayView.circleView?.isHidden = false
            dayView.circleView?.backgroundColor = UIColor.red
            dayView.dotView?.backgroundColor = UIColor.white
            dayView.textLabel?.textColor = UIColor.white
        }
        else if !(calendarManager?.dateHelper?.isTheSameMonthThan(calendarContentView.date!, dayView.date!))! {
            dayView.circleView?.isHidden = true
            dayView.dotView?.backgroundColor = UIColor.red
            dayView.textLabel?.textColor = UIColor.lightGray
        }
        else {
            dayView.circleView?.isHidden = true
            dayView.dotView?.backgroundColor = UIColor.red
            dayView.textLabel?.textColor = UIColor.black
        }
        
        //Events
//        if haveEvent(forDay: dayView.date!) {
//            dayView.dotView?.isHidden = false
//        }
//        else {
//            dayView.dotView?.isHidden = true
//        }
    }
    
    //Touch Day View
    func calendar(_ calendar: JTSCalendarManager, didTouchDayView dayView: JTSCalendarDayView) {
        _dateSelected = dayView.date
        // Animation for the circleView
        dayView.circleView?.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.transition(with: dayView, duration: 0.3, options: [], animations: {
            dayView.circleView?.transform = .identity
            self.calendarManager?.reload()
        }) { (compeleted) in
            
        }
        // Don't change page in week mode because block the selection of days in first and last weeks of the month
        if (calendarManager?.settings?.isWeekModeEnabled)! {
            return
        }
        // Load the previous or next page if touch a day from another month
        if !(calendarManager?.dateHelper?.isTheSameMonthThan(calendarContentView.date!, dayView.date!))! {
            if calendarContentView.date?.compare(dayView.date!) == .orderedAscending {
                calendarContentView.loadNextPageWithAnimation()
            }
            else {
                calendarContentView.loadPreviousPageWithAnimation()
            }
        }

    }
    
    //Load Months before and after
    func calendar(_ calendar: JTSCalendarManager, canDisplayPageWith date: Date) -> Bool {
        return (calendarManager?.dateHelper?.isBetweenAtStartDateAndEndDate(date, startDate: _minDate!, endDate: _maxDate!))!
    }
    
    //Loading Pages
    func calendarDidLoadPreviousPage(_ calendar: JTSCalendarManager) {
        print("Previous Page loaded")
    }
    
    func calendarDidLoadNextPage(_ calendar: JTSCalendarManager) {
        print("Next Page loaded")
    }
}

