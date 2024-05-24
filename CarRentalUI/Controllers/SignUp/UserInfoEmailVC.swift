//
//  UserInfoEmailVC.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 15/07/23.
//
// MARK: - Navigation

import UIKit
import IQKeyboardManagerSwift

class UserInfoEmailVC: UIViewController {
    
    @IBOutlet weak var PromiseWeWontSpamYouLbl: UILabel!
    @IBOutlet weak var emailTxtFieldView: UIView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var NSLC_BtnBottom: NSLayoutConstraint!
    
    private var addSpacing: CGFloat = 25.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.disabledToolbarClasses = [UserInfoEmailVC.self]
        emailTxtFieldView.layer.cornerRadius = 5
        submitBtn.layer.cornerRadius = 5
        
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
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func checkValidation() {
        guard let email = emailTxtField.text, !email.isEmpty else {
            showAlert(withTitle: "Error", message: "Please enter email.")
            return
        }
        
        guard isValidEmail(email: email) else {
            showAlert(withTitle: "Error", message: "Please enter a valid email.")
            return
        }
        
        UserDefaults.standard.set(true, forKey: "USER_LOGIN")
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "HomeVC") as UIViewController
        navigationController.viewControllers = [rootViewController]
        AppDelegate.sharedApplication().window?.rootViewController = navigationController
        
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        checkValidation()
    }
}
