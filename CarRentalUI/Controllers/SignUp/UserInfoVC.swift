//
//  UserInfoVC.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 15/07/23.
//
// MARK: - Navigation

import UIKit
import IQKeyboardManagerSwift

class UserInfoVC: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var tellUsAboutYouLbl: UILabel!
    @IBOutlet weak var NSLC_BtnBottom: NSLayoutConstraint!
    @IBOutlet weak var firstNametxtFieldView: UIView!
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtFieldView: UIView!
    @IBOutlet weak var dateOfBirthTxtFieldView: UIView!
    @IBOutlet weak var dateOfBirthTxtField: UITextField!
    
    let datePicker = UIDatePicker()
    private var addSpacing: CGFloat = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.disabledToolbarClasses = [UserInfoVC.self]
        
        setupDatePicker()
        nextBtn.layer.cornerRadius = 5
        firstNametxtFieldView.layer.cornerRadius = 5
        lastNameTxtFieldView.layer.cornerRadius = 5
        dateOfBirthTxtFieldView.layer.cornerRadius = 5
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        NSLC_BtnBottom.constant = keyboardFrame.height + addSpacing
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        NSLC_BtnBottom.constant = 40
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClicked))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        dateOfBirthTxtField.inputView = datePicker
        dateOfBirthTxtField.inputAccessoryView = toolBar
    }
    
    @objc func doneClicked() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateOfBirthTxtField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelClicked() {
        self.view.endEditing(true)
    }
    
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func checkValidation() {
        guard let firstName = firstNameTxtField.text, !firstName.isEmpty else {
            showAlert(withTitle: "Error", message: "Please enter first name.")
            return
        }
        
        guard let lastName = lastNameTxtField.text, !lastName.isEmpty else {
            showAlert(withTitle: "Error", message: "Please enter last name.")
            return
        }
        
        guard let birthdate = dateOfBirthTxtField.text, !birthdate.isEmpty else {
            showAlert(withTitle: "Error", message: "Please enter birthdate")
            return
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "SignUp", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UserInfoEmailVC") as! UserInfoEmailVC
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        checkValidation()
    }
}
