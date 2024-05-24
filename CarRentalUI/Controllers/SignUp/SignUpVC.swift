//
//  SignUpVC.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 14/07/23.
//
// MARK: - Navigation

import UIKit
import SKCountryPicker
import IQKeyboardManagerSwift

class SignUpVC: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var letGetTravellingLbl: UILabel!
    @IBOutlet weak var areYouAnAgencyBtn: UIButton!
    @IBOutlet weak var agencySwitch: UISwitch!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var countryFlagImg: UIImageView!
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var phoneNumberTxtField: UITextField!
    @IBOutlet weak var NSLC_BtnBottom: NSLayoutConstraint!
    @IBOutlet weak var countryCodeLbl: UILabel!
    
    private var addSpacing: CGFloat = 25.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.disabledToolbarClasses = [SignUpVC.self]
        nextBtn.layer.cornerRadius = 5
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        countryManager()
    }
    
    private func countryManager() {
        guard let country = CountryManager.shared.currentCountry else {
            self.countryCodeLbl.text = "Pick Country"
            self.countryFlagImg.isHidden = true
            return
        }
        
        countryCodeLbl.text = country.dialingCode
        countryFlagImg.image = country.flag
        countryCodeBtn.clipsToBounds = true
        countryCodeLbl.clipsToBounds = true
        countryCodeBtn.accessibilityLabel = Accessibility.selectCountryPicker
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
    
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func isValidPhoneNumber(phoneNumber: String) -> Bool {
        let phoneNumberRegex = "^[0-9]{10}$"
        let phoneNumberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        return phoneNumberPredicate.evaluate(with: phoneNumber)
    }
    
    private func checkValidation() {
        guard let countryCode = countryCodeLbl.text, countryCode != "Pick Country" else {
            showAlert(withTitle: "Error", message: "Please select a country code.")
            return
        }
        
        guard let phoneNumber = phoneNumberTxtField.text, !phoneNumber.isEmpty else {
            showAlert(withTitle: "Error", message: "Please enter a phone number.")
            return
        }
        
        guard isValidPhoneNumber(phoneNumber: phoneNumber) else {
            showAlert(withTitle: "Error", message: "Please enter a valid phone number.")
            return
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "SignUp", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "VerificationVC") as! VerificationVC
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func agencySwitchTapped(_ sender: UISwitch) {
        
    }
    
    @IBAction func countryCodeBtnTapped(_ sender: UIButton) {
        presentCountryPickerScene()
    }
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        checkValidation()
    }
}

private extension SignUpVC {
    func presentCountryPickerScene(withSelectionControlEnabled selectionControlEnabled: Bool = true) {
        switch selectionControlEnabled {
        case true:
            CountryPickerWithSectionViewController.presentController(on: self, configuration: { countryController in
                countryController.configuration.flagStyle = .circular
                countryController.favoriteCountriesLocaleIdentifiers = ["IN", "US"]
                
            }) { [weak self] country in
                
                guard let self = self else { return }
                self.countryFlagImg.isHidden = false
                self.countryFlagImg.image = country.flag
                self.countryCodeLbl.text = country.dialingCode
            }
            
        case false:
            CountryPickerController.presentController(on: self, configuration: { countryController in
                countryController.configuration.flagStyle = .corner
                countryController.favoriteCountriesLocaleIdentifiers = ["IN", "US"]
                
            }) { [weak self] country in
                
                guard let self = self else { return }
                
                self.countryFlagImg.isHidden = false
                self.countryFlagImg.image = country.flag
                self.countryCodeLbl.text = country.dialingCode
            }
        }
    }
}
