//
//  CalenderVC.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 20/07/23.
//
// MARK: - Navigation

import UIKit
import FSCalendar

class CalenderVC: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    var delegate: CalenderVCDelegate? = nil
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var doneBtn: UIButton!
    
    var dynamicDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]
        self.calendar.select(dynamicDate)
        
        let scopeGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        self.calendar.addGestureRecognizer(scopeGesture)
        self.calendar.accessibilityIdentifier = "calendar"
    }
    
    fileprivate var lunar: Bool = false {
        didSet {
            self.calendar.reloadData()
        }
    }
    
    fileprivate var theme: Int = 0 {
        didSet {
            switch (theme) {
            case 0:
                self.calendar.appearance.weekdayTextColor = UIColor(red: 14/255.0, green: 69/255.0, blue: 221/255.0, alpha: 1.0)
                self.calendar.appearance.headerTitleColor = UIColor(red: 14/255.0, green: 69/255.0, blue: 221/255.0, alpha: 1.0)
                self.calendar.appearance.eventDefaultColor = UIColor(red: 31/255.0, green: 119/255.0, blue: 219/255.0, alpha: 1.0)
                self.calendar.appearance.selectionColor = UIColor(red: 31/255.0, green: 119/255.0, blue: 219/255.0, alpha: 1.0)
                self.calendar.appearance.headerDateFormat = "MMMM yyyy"
                self.calendar.appearance.todayColor = UIColor(red: 198/255.0, green: 51/255.0, blue: 42/255.0, alpha: 1.0)
                self.calendar.appearance.borderRadius = 1.0
                self.calendar.appearance.headerMinimumDissolvedAlpha = 0.2
            case 1:
                self.calendar.appearance.weekdayTextColor = UIColor.red
                self.calendar.appearance.headerTitleColor = UIColor.darkGray
                self.calendar.appearance.eventDefaultColor = UIColor.green
                self.calendar.appearance.selectionColor = UIColor.blue
                self.calendar.appearance.headerDateFormat = "yyyy-MM";
                self.calendar.appearance.todayColor = UIColor.red
                self.calendar.appearance.borderRadius = 1.0
                self.calendar.appearance.headerMinimumDissolvedAlpha = 0.0
            case 2:
                self.calendar.appearance.weekdayTextColor = UIColor.red
                self.calendar.appearance.headerTitleColor = UIColor.red
                self.calendar.appearance.eventDefaultColor = UIColor.green
                self.calendar.appearance.selectionColor = UIColor.blue
                self.calendar.appearance.headerDateFormat = "yyyy/MM"
                self.calendar.appearance.todayColor = UIColor.orange
                self.calendar.appearance.borderRadius = 0
                self.calendar.appearance.headerMinimumDissolvedAlpha = 1.0
            default:
                break;
            }
        }
    }
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    // MARK:- FSCalendarDelegate
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("change page to \(self.formatter.string(from: calendar.currentPage))")
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("calendar did select date \(self.formatter.string(from: date))")
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneBtnTapped(_ sender: UIButton) {
        self.delegate?.sendDate(date: calendar.selectedDate ?? Date())
        navigationController?.popViewController(animated: true)
    }
}

protocol CalenderVCDelegate {
    func sendDate(date: Date)
}
