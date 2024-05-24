//
//  CreateNewEventVC.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 20/07/23.
//
// MARK: - Navigation

import UIKit
import DropDown

class CreateNewEventVC: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var navTitleLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var modelNameView: UIView!
    @IBOutlet weak var modelNameTxtField: UITextField!
    @IBOutlet weak var LocationView: UIView!
    @IBOutlet weak var locationArrowBtn: UIButton!
    @IBOutlet weak var locationTxtField: UITextField!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateTxtField: UITextField!
    @IBOutlet weak var dateArrowBtn: UIButton!
    @IBOutlet weak var availabilityView: UIView!
    @IBOutlet weak var availabilityArrowBtn: UIButton!
    @IBOutlet weak var availabilityTxtField: UITextField!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceTxtField: UITextField!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTxtField: UITextField!
    
    let datePicker = UIDatePicker()
    
    let selectLocationDropDown = DropDown()
    let selectAvailabilityDropDown = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [self.selectLocationDropDown, self.selectAvailabilityDropDown]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTxtFieldsViews()
        setupDatePicker()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGestureRecognizer)
        setupLocationDropDown()
        setupavailabilityDropDown()
    }
    
    func setupLocationDropDown() {
        selectLocationDropDown.anchorView = LocationView
        selectLocationDropDown.bottomOffset = CGPoint(x: 0, y: LocationView.bounds.height)
        selectLocationDropDown.dataSource = [
            "Surat",
            "Rajkot",
            "Ahemdabad",
            "Junagadh",
            "Gandhinagar"
        ]
        
        selectLocationDropDown.selectionAction = { [weak self] (index, item) in
            self?.locationTxtField.text = item
        }
    }
    
    func setupavailabilityDropDown() {
        selectAvailabilityDropDown.anchorView = availabilityView
        selectAvailabilityDropDown.bottomOffset = CGPoint(x: 0, y: availabilityView.bounds.height)
        selectAvailabilityDropDown.dataSource = [
            "Yes",
            "No"
        ]
        
        selectAvailabilityDropDown.selectionAction = { [weak self] (index, item) in
            self?.availabilityTxtField.text = item
        }
    }
    
    private func configureTxtFieldsViews() {
        modelNameView.layer.cornerRadius = 5
        LocationView.layer.cornerRadius = 5
        dateView.layer.cornerRadius = 5
        availabilityView.layer.cornerRadius = 5
        priceView.layer.cornerRadius = 5
        descriptionView.layer.cornerRadius = 5
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
        dateTxtField.inputView = datePicker
        dateTxtField.inputAccessoryView = toolBar
    }
    
    @objc func doneClicked() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateTxtField.text = dateFormatter.string(from: datePicker.date)
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
        guard let modelName = modelNameTxtField.text, !modelName.isEmpty else {
            showAlert(withTitle: "Error", message: "Please enter model name.")
            return
        }
        
        guard let location = locationTxtField.text, !location.isEmpty else {
            showAlert(withTitle: "Error", message: "Please select location.")
            return
        }
        
        guard let date = dateTxtField.text, !date.isEmpty else {
            showAlert(withTitle: "Error", message: "Please select date.")
            return
        }
        
        guard let availability = availabilityTxtField.text, !availability.isEmpty else {
            showAlert(withTitle: "Error", message: "Please select availability.")
            return
        }
        
        guard let price = priceTxtField.text, !price.isEmpty else {
            showAlert(withTitle: "Error", message: "Please enter price.")
            return
        }
        
        guard let description = descriptionTxtField.text, !description.isEmpty else {
            showAlert(withTitle: "Error", message: "Please enter description.")
            return
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        checkValidation()
    }
}

extension CreateNewEventVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == locationTxtField {
            selectLocationDropDown.show()
        } else if textField == availabilityTxtField {
            selectAvailabilityDropDown.show()
        }
        return true
    }
}





