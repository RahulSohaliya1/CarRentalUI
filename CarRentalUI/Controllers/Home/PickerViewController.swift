//
//  PickerViewController.swift
//  TestCountryPickerFramework
//
//  Created by DREAMWORLD on 14/07/23.

import UIKit
import SKCountryPicker

class PickerViewController: UIViewController {
    
    @IBOutlet weak var storyboardPickerView: CountryPickerView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var storyboardLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerViewForTextField()
        setupStoryboardPickerViewCallback()
    }
    
    private func setupPickerViewForTextField() {
        let picketView = CountryPickerView.loadPickerView { [weak self] (country) in
            
            guard let self = self,
                  let digitCountrycode = country.digitCountrycode else {
                      return
                  }
            let text = "\(digitCountrycode) \(country.countryCode)"
            self.textField.text = text
        }
        
        picketView.setPickList(codes: "AQ", "IL", "AF", "AL", "DZ", "IN")
        textField.inputView = picketView
        
        let toolBar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        toolBar.items = [doneButton]
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTapped() {
        self.textField.resignFirstResponder()
    }
    
    private func setupStoryboardPickerViewCallback() {
        storyboardPickerView.setSelectedCountry(Country(countryCode: "GB"))
        storyboardPickerView.onSelectCountry { [weak self] (country) in
            guard let self = self,
                  let digitCountrycode = country.digitCountrycode else {
                      return
                  }
            let text = "\(digitCountrycode) \(country.countryCode)"
            self.storyboardLabel.text = text
        }
    }
}
