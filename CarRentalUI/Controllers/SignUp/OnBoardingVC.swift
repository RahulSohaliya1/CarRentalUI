//
//  OnBoardingVC.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 14/07/23.
//
// MARK: - Navigation

import UIKit
import SKCountryPicker
import IQKeyboardManagerSwift

class OnBoardingVC: UIViewController {
    
    @IBOutlet weak var carRentalLbl: UILabel!
    @IBOutlet weak var letsGetTravellingLbl: UILabel!
    @IBOutlet weak var areYouAnAgencyBtn: UIButton!
    @IBOutlet weak var agencySwitch: UISwitch!
    @IBOutlet weak var countryFlagImg: UIImageView!
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var phoneNumberTxtField: UITextField!
    @IBOutlet weak var countryCodeLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGestureRecognizer)
        IQKeyboardManager.shared.disabledToolbarClasses = [OnBoardingVC.self]
        countryManager()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    private func countryManager() {
        guard let country = CountryManager.shared.currentCountry else {
            self.countryCodeLbl.text = "Pick Country"
            self.countryFlagImg.isHidden = true
            return
        }
        
        countryCodeLbl.text = country.dialingCode
        countryFlagImg.image = country.flag
        countryCodeLbl.clipsToBounds = true
        countryCodeBtn.accessibilityLabel = Accessibility.selectCountryPicker
    }
    
    @IBAction func areYouAnAgencyBtnTapped(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "SignUp", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func countryCodeBtnTapped(_ sender: UIButton) {
        presentCountryPickerScene()
    }
}

private extension OnBoardingVC {
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
