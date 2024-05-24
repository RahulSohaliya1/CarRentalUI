//
//  ContactSupportVC.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 19/07/23.
//
// MARK: - Navigation

import UIKit
import IQKeyboardManagerSwift

class ContactSupportVC: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var NavTitleLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var contactSupportTxtView: UITextView!
    
    let contactSupport = "Write here..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        `IQKeyboardManager`.shared.disabledToolbarClasses = [ContactSupportVC.self]
        txtViewConfigure()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func txtViewConfigure() {
        contactSupportTxtView.delegate = self
        contactSupportTxtView.text = contactSupport
        contactSupportTxtView.textColor = UIColor.lightGray
        contactSupportTxtView.layer.cornerRadius = 5
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func checkValidation() {
        guard let contactSupport = contactSupportTxtView.text, !contactSupport.isEmpty, contactSupport != "Write here..." else {
            showAlert(message: "Please enter details.")
            return
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CreateNewCarVC") as! CreateNewCarVC
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func okBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        checkValidation()
    }
}

extension ContactSupportVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == contactSupport {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = contactSupport
            textView.textColor = UIColor.lightGray
        }
    }
}

