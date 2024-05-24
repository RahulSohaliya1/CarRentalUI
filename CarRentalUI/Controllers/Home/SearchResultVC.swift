//
//  SearchResultVC.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 18/07/23.
//
// MARK: - Navigation

import UIKit

class SearchResultVC: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var calenderBtn: UIButton!
    @IBOutlet weak var carDetailstableView: UITableView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var sortByBtn: UIButton!
    @IBOutlet var popupView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var popUpOKBtn: UIButton!
    @IBOutlet weak var customActionSheet: UIView!
    @IBOutlet weak var sheetFilterLbl: UILabel!
    @IBOutlet weak var sheetPopularBtn: UIButton!
    @IBOutlet weak var sheetLowToHighPriceBtn: UIButton!
    @IBOutlet weak var sheetHighToLowPriceBtn: UIButton!
    @IBOutlet weak var sheetTopListBtn: UIButton!
    @IBOutlet weak var sheetCancelBtn: UIButton!
    @IBOutlet weak var sheetDoneBtn: UIButton!
    
    var effect: UIVisualEffect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carDetailsNibRegister()
        configurePopUp()
        sheetPopularBtn.layer.cornerRadius = 5
    }
    
    private func configurePopUp() {
        
        
        effect = visualEffectView.effect
        
        
        visualEffectView.effect = nil
        
        
        popupView.layer.cornerRadius = 15
    }
    
    func animateIn() {
        self.view.addSubview(popupView)
        popupView.center = self.view.center
        popupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popupView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.effect = self.effect
            self.popupView.alpha = 1
            self.popupView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.popupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.popupView.alpha = 0
            
            self.visualEffectView.effect = nil
        }) { (success: Bool) in
            self.popupView.removeFromSuperview()
        }
    }
    
    @objc func popUpIn(_ sender: UIButton) {
        visualEffectView.isHidden = false
        animateIn()
    }
    
    @objc func timeSelectionVC(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TimeSelectionVC") as! TimeSelectionVC
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @objc func reviewsVC(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ReviewsVC") as! ReviewsVC
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func popUpOKBtnTapped(_ sender: UIButton) {
        visualEffectView.isHidden = true
        animateOut()
    }
    
    private func carDetailsNibRegister() {
        let nibFile: UINib = UINib(nibName: "CarDetailsTableViewCell", bundle: nil)
        carDetailstableView.register(nibFile, forCellReuseIdentifier: "CarDetailsTableViewCell")
        carDetailstableView.separatorStyle = .none
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func calenderBtnTapped(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CalenderVC") as! CalenderVC
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func filterBtnTapped(_ sender: UIButton) {
        customActionSheet.isHidden = false
        self.visualEffectView.effect = self.effect
        visualEffectView.isHidden = false
    }
    
    @IBAction func sortByBtnTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func sheetPopularBtnTapped(_ sender: UIButton) {
        sheetPopularBtn.backgroundColor = .black
        sheetPopularBtn.tintColor = .white
        sheetPopularBtn.layer.cornerRadius = 5
        sheetLowToHighPriceBtn.backgroundColor = .clear
        sheetLowToHighPriceBtn.tintColor = .darkGray
        sheetHighToLowPriceBtn.backgroundColor = .clear
        sheetHighToLowPriceBtn.tintColor = .darkGray
        sheetTopListBtn.backgroundColor = .clear
        sheetTopListBtn.tintColor = .darkGray
    }
    
    @IBAction func sheetLowToHighBtnTapped(_ sender: UIButton) {
        sheetLowToHighPriceBtn.backgroundColor = .black
        sheetLowToHighPriceBtn.tintColor = .white
        sheetLowToHighPriceBtn.layer.cornerRadius = 5
        sheetPopularBtn.backgroundColor = .clear
        sheetPopularBtn.tintColor = .darkGray
        sheetHighToLowPriceBtn.backgroundColor = .clear
        sheetHighToLowPriceBtn.tintColor = .darkGray
        sheetTopListBtn.backgroundColor = .clear
        sheetTopListBtn.tintColor = .darkGray
    }
    
    @IBAction func sheetHighToLowBtnTapped(_ sender: UIButton) {
        sheetHighToLowPriceBtn.backgroundColor = .black
        sheetHighToLowPriceBtn.tintColor = .white
        sheetHighToLowPriceBtn.layer.cornerRadius = 5
        sheetPopularBtn.backgroundColor = .clear
        sheetPopularBtn.tintColor = .darkGray
        sheetLowToHighPriceBtn.backgroundColor = .clear
        sheetLowToHighPriceBtn.tintColor = .darkGray
        sheetTopListBtn.backgroundColor = .clear
        sheetTopListBtn.tintColor = .darkGray
    }
    
    @IBAction func sheetTopListBtnTapped(_ sender: UIButton) {
        sheetTopListBtn.backgroundColor = .black
        sheetTopListBtn.tintColor = .white
        sheetTopListBtn.layer.cornerRadius = 5
        sheetPopularBtn.backgroundColor = .clear
        sheetPopularBtn.tintColor = .darkGray
        sheetLowToHighPriceBtn.backgroundColor = .clear
        sheetLowToHighPriceBtn.tintColor = .darkGray
        sheetHighToLowPriceBtn.backgroundColor = .clear
        sheetHighToLowPriceBtn.tintColor = .darkGray
    }
    
    @IBAction func sheetCancelBtnTapped(_ sender: UIButton) {
        customActionSheet.isHidden = true
        self.visualEffectView.effect = nil
        visualEffectView.isHidden = true
    }
    
    @IBAction func sheetDoneBtnTapped(_ sender: UIButton) {
        customActionSheet.isHidden = true
        self.visualEffectView.effect = nil
        visualEffectView.isHidden = true
    }
}

extension SearchResultVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarDetailsTableViewCell = carDetailstableView.dequeueReusableCell(withIdentifier: "CarDetailsTableViewCell", for: indexPath) as! CarDetailsTableViewCell
        cell.readMoreBtn.addTarget(self, action: #selector(popUpIn), for: .touchUpInside)
        cell.bookBtn.addTarget(self, action: #selector(timeSelectionVC), for: .touchUpInside)
        cell.reviewBtn.addTarget(self, action: #selector(reviewsVC), for: .touchUpInside)
        return cell
    }
}

