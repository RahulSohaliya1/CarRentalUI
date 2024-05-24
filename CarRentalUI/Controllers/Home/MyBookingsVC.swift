//
//  MyBookingsVC.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 19/07/23.
//
// MARK: - Navigation

import UIKit

class MyBookingsVC: UIViewController {
    
    @IBOutlet weak var BookingTitleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var CalenderBtn: UIButton!
    @IBOutlet weak var bookingsTableView: UITableView!
    @IBOutlet weak var contactUsBtn: UIButton!
    
    private var carNames: [String] = ["Audi A4 Sedan", "Audi A6 Allroad Quattro"]
    private var locations: [String] = ["Add Location", "Barcelona"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookingsNibRegister()
    }
    
    private func bookingsNibRegister() {
        let nibFile: UINib = UINib(nibName: "MyBookingsTableViewCell", bundle: nil)
        bookingsTableView.register(nibFile, forCellReuseIdentifier: "MyBookingsTableViewCell")
        bookingsTableView.separatorStyle = .singleLine
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func calenderBtnTapped(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CalenderVC") as! CalenderVC
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func contactUsBtnTapped(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ContactSupportVC") as! ContactSupportVC
        navigationController?.pushViewController(vc, animated: true);
    }
}

extension MyBookingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyBookingsTableViewCell = bookingsTableView.dequeueReusableCell(withIdentifier: "MyBookingsTableViewCell", for: indexPath) as! MyBookingsTableViewCell
        cell.carNameLbl.text = "\(carNames[indexPath.row])"
        cell.addLocationLbl.text = "\(locations[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
