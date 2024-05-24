//
//  ReviewsVC.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 19/07/23.
//
// MARK: - Navigation

import UIKit

class ReviewsVC: UIViewController {
    
    @IBOutlet weak var reviewTitleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var reviewsTableView: UITableView!
    
    private var reviewersName: [String] = ["John Doe", "Jake Tyson", "Marry Jackson", "Rainer Zufall", "Volker Putt", "Ann Geber"]
    private var reviewersMsg: [String] = ["I like the service.", "Good Car.", "I am happy with the service.", "Nice app.", "Cheaper price & good service.", "I enjoy my overall experience."]
    private var reviewTiming: [String] = ["10m ago", "06:55 AM", "29/03/18", "28/03/18", "26/03/18", "25/01/18  "]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewsNibRegister()
    }
    
    private func reviewsNibRegister() {
        let nibFile: UINib = UINib(nibName: "ReviewsTableViewCell", bundle: nil)
        reviewsTableView.register(nibFile, forCellReuseIdentifier: "ReviewsTableViewCell")
        reviewsTableView.separatorStyle = .singleLine
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension ReviewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewersName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReviewsTableViewCell = reviewsTableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell", for: indexPath) as! ReviewsTableViewCell
        cell.nameLbl.text = "\(reviewersName[indexPath.row])"
        cell.reviewMsgLbl.text = "\(reviewersMsg[indexPath.row])"
        cell.showTimingLbl.text = "\(reviewTiming[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
