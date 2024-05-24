//
//  VerificationVC.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 15/07/23.
//
// MARK: - Navigation

import UIKit
import SVPinView
import IQKeyboardManagerSwift

class VerificationVC: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var verificationLbl: UILabel!
    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var DoneBtn: UIButton!
    @IBOutlet weak var NSLC_BtnBottom: NSLayoutConstraint!
    @IBOutlet weak var resendCodeBtn: UIButton!
    @IBOutlet weak var contactSupportBtn: UIButton!
    @IBOutlet weak var pinView: SVPinView!
    
    private var addSpacing: CGFloat = 25.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.disabledToolbarClasses = [VerificationVC.self]
        
        configurePinView()
        DoneBtn.layer.cornerRadius = 5
        
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
    
    func didFinishEnteringPin(enteredOTP: String) {
        
        if pinView.getPin().isEmpty {
            showAlert(title: "Error", message: "Please enter the OTP.")
            return
        }
        
        let enteredOTP = pinView.getPin()
        let validOTP = "1234" // Replace with your valid OTP
        
        if enteredOTP == validOTP {
            print("otp is valid.")
        } else {
            showAlert(title: "Error", message: "Invalid OTP. Please try again.")
        }
    }
    
    func configurePinView() {
        pinView.pinLength = 4
        pinView.secureCharacter = "\u{25CF}"
        pinView.interSpace = 10
        pinView.textColor = UIColor.black
        pinView.borderLineColor = UIColor.black
        pinView.activeBorderLineColor = UIColor.systemGray2
        pinView.borderLineThickness = 1
        pinView.shouldSecureText = true
        pinView.allowsWhitespaces = false
        pinView.style = .box
        pinView.fieldBackgroundColor = UIColor.systemGray4.withAlphaComponent(0.3)
        pinView.activeFieldBackgroundColor = UIColor.systemGray3.withAlphaComponent(0.5)
        pinView.fieldCornerRadius = 15
        pinView.activeFieldCornerRadius = 15
        pinView.placeholder = "******"
        pinView.deleteButtonAction = .deleteCurrentAndMoveToPrevious
        pinView.keyboardAppearance = .default
        pinView.tintColor = .white
        pinView.becomeFirstResponderAtIndex = 0
        pinView.shouldDismissKeyboardOnEmptyFirstField = false
        
        pinView.font = UIFont.systemFont(ofSize: 15)
        pinView.keyboardType = .phonePad
        pinView.pinInputAccessoryView = { () -> UIView in
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
            doneToolbar.barStyle = UIBarStyle.default
            let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(handleTap))
            
            var items = [UIBarButtonItem]()
            items.append(flexSpace)
            items.append(done)
            
            doneToolbar.items = items
            doneToolbar.sizeToFit()
            return doneToolbar
        }()
        
        pinView.didFinishCallback = didFinishEnteringPin(enteredOTP:)
        pinView.didChangeCallback = { pin in
            print("The entered pin is \(pin)")
        }
    }
    
    // MARK: Helper Functions
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setGradientBackground(view:UIView, colorTop:UIColor, colorBottom:UIColor) {
        for layer in view.layer.sublayers! {
            if layer.name == "gradientLayer" {
                layer.removeFromSuperlayer()
            }
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        gradientLayer.name = "gradientLayer"
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBAction func resendCodeBtnTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func contactSupportBtnTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func DoneBtnTapped(_ sender: UIButton) {
        
        didFinishEnteringPin(enteredOTP: "")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "SignUp", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UserInfoVC") as! UserInfoVC
        navigationController?.pushViewController(vc, animated: true);
    }
}
