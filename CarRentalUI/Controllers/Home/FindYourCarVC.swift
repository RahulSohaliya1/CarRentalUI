//
//  FindYourCarVC.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 18/07/23.
//
// MARK: - Navigation

import UIKit
import DropDown

class FindYourCarVC: UIViewController, CalenderVCDelegate {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var calenderBtn: UIButton!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var dropDownArrowBtn: UIButton!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var SearchBtn: UIButton!
    @IBOutlet weak var NSLC_BtnBottom: NSLayoutConstraint!
    @IBOutlet weak var includeAgencyView: UIView!
    @IBOutlet weak var includeTours: UIView!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var dateNumberLbl: UILabel!
    @IBOutlet weak var daysLbl: UILabel!
    @IBOutlet weak var monthsLbl: UILabel!
    @IBOutlet weak var calenderHiddenBtn: UIButton!
    @IBOutlet weak var selectAreaTxtField: UITextField!
    
    let areaDropDown = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [self.areaDropDown]
    }()
    
    var dynamicDate = Date()
    
    private var addSpacing: CGFloat = 25.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calender(date: Date())
        
        calenderView.layer.cornerRadius = 5
        calenderView.layer.borderWidth = 1
        calenderView.layer.borderColor = UIColor.systemGray4.cgColor
        
        dropDownView.layer.cornerRadius = 5
        includeAgencyView.layer.borderWidth = 1
        includeAgencyView.layer.borderColor = UIColor.systemGray4.cgColor
        
        includeTours.layer.borderWidth = 1
        includeTours.layer.borderColor = UIColor.systemGray4.cgColor
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupAreaDropDown()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        NSLC_BtnBottom.constant = keyboardFrame.height + addSpacing
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        NSLC_BtnBottom.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func calender(date: Date) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd"
        let numDate = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "MMM"
        let month = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "EEE"
        let day = dateFormatter.string(from: date)
        
        print(numDate, year, month, day)
        
        self.dateNumberLbl.text = numDate
        self.monthsLbl.text = month
        self.daysLbl.text = day
    }
    
    func sendDate(date: Date) {
        dynamicDate = date
        calender(date: date)
    }
    
    func setupAreaDropDown() {
        areaDropDown.anchorView = dropDownView
        areaDropDown.bottomOffset = CGPoint(x: 0, y: dropDownView.bounds.height)
        areaDropDown.dataSource = [
            "Surat",
            "Rajkot",
            "Ahemdabad",
            "Junagadh",
            "Gandhinagar"
        ]
        
        areaDropDown.selectionAction = { [weak self] (index, item) in
            self?.selectAreaTxtField.text = item
        }
    }
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func calenderBtnTapped(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CalenderVC") as! CalenderVC
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func dropDownArrowBtnTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func calenderHiddenBtnTapped(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CalenderVC") as! CalenderVC
        vc.delegate = self
        vc.dynamicDate = dynamicDate
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func searchBtnTapped(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SearchResultVC") as! SearchResultVC
        navigationController?.pushViewController(vc, animated: true);
    }
}

extension FindYourCarVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        areaDropDown.show()
        return false
    }
}
