//
//  CreateNewCarVC.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 20/07/23.
//

import UIKit
import DropDown
import Photos

class CreateNewCarVC: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var navTitleLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addedCarImgView: UIImageView!
    @IBOutlet weak var carView: UIView!
    @IBOutlet weak var modelNameView: UIView!
    @IBOutlet weak var attributesView: UIView!
    @IBOutlet weak var selectCompanyView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var modelNameTxtField: UITextField!
    @IBOutlet weak var attributesTxtField: UITextField!
    @IBOutlet weak var selectCompanyDropDownTxtField: UITextField!
    @IBOutlet weak var priceTxtField: UITextField!
    @IBOutlet weak var descriptionTxtField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    var imagePicker: UIImagePickerController?
    var cameraController: UIImagePickerController?
    
    let selectLogoDropDown = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [self.selectLogoDropDown]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGestureRecognizer)
        configureViews()
        setupLogoDropDown()
        
        addedCarImgView.layer.cornerRadius = 5
        let interaction = UIContextMenuInteraction(delegate: self)
        addedCarImgView.addInteraction(interaction)
        addedCarImgView.isUserInteractionEnabled = true
    }
    
    func setupLogoDropDown() {
        selectLogoDropDown.anchorView = selectCompanyView
        selectLogoDropDown.bottomOffset = CGPoint(x: 0, y: selectCompanyView.bounds.height)
        selectLogoDropDown.dataSource = [
            "Surat",
            "Rajkot",
            "Ahemdabad",
            "Junagadh",
            "Gandhinagar"
        ]
        
        selectLogoDropDown.selectionAction = { [weak self] (index, item) in
            self?.selectCompanyDropDownTxtField.text = item
        }
    }
    
    private func configureViews() {
        carView.layer.cornerRadius = 5
        modelNameView.layer.cornerRadius = 5
        attributesView.layer.cornerRadius = 5
        selectCompanyView.layer.cornerRadius = 5
        priceView.layer.cornerRadius = 5
        descriptionView.layer.cornerRadius = 5
    }
    
    @objc func handleTap() {
        view.endEditing(true)
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
        
        guard let attributes = attributesTxtField.text, !attributes.isEmpty else {
            showAlert(withTitle: "Error", message: "Please enter attributes.")
            return
        }
        
        guard let selectCompany = selectCompanyDropDownTxtField.text, !selectCompany.isEmpty else {
            showAlert(withTitle: "Error", message: "Please select Company logo.")
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
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CreateNewEventVC") as! CreateNewEventVC
        navigationController?.pushViewController(vc, animated: true);
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

extension CreateNewCarVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        selectLogoDropDown.show()
        return false
    }
}

extension CreateNewCarVC: UIContextMenuInteractionDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        let CameraAction = UIAction(title: "Camera", image: UIImage(systemName: "camera")) { [weak self] _ in
            self?.CameraImage()
        }
        
        let PhotosAction = UIAction(title: "Photos", image: UIImage(systemName: "photo.on.rectangle")) { [weak self] _ in
            self?.PhotosImage()
        }
        
        let menu = UIMenu(title: "Choose Option", children: [CameraAction, PhotosAction])
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
            return menu
        }
    }
    
    private func CameraImage() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraController = UIImagePickerController()
            cameraController?.delegate = self
            cameraController?.sourceType = .camera
            cameraController?.allowsEditing = true
            present(cameraController!, animated: true, completion: nil)
        } else {
            showAlert(withTitle: "Camera", message: "Camera is not available.")
        }
    }
    
    private func PhotosImage() {
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.sourceType = .photoLibrary
        imagePicker?.allowsEditing = true
        present(imagePicker!, animated: true, completion: nil)
    }
    
    private func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePicker: UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        if let editedImage = info[.editedImage] as? UIImage {
            addedCarImgView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            addedCarImgView.image = originalImage
        }
        
        addedCarImgView.image = image
        addedCarImgView.contentMode = .scaleAspectFill
        addedCarImgView.clipsToBounds = true
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
