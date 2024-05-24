//
//  TimeSelectionVC.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 19/07/23.
//
// MARK: - Navigation


import UIKit

class TimeSelectionVC: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var calenderBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dummyBtn: UIButton!
    @IBOutlet weak var timeSelectionCollectionView: UICollectionView!
    
    private var timeSlots: [String] = ["00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00", "07:00", "08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeSelectionNibRegister()
    }
    
    private func timeSelectionNibRegister() {
        let nibFile: UINib = UINib(nibName: "TimeSelectionCollectionViewCell", bundle: nil)
        timeSelectionCollectionView.register(nibFile, forCellWithReuseIdentifier: "TimeSelectionCollectionViewCell")
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func calenderBtnTapped(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CalenderVC") as! CalenderVC
        navigationController?.pushViewController(vc, animated: true);
    }
    
    @IBAction func dummyBtnTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func confirmBtnTapped(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MyBookingsVC") as! MyBookingsVC
        navigationController?.pushViewController(vc, animated: true);
    }
}

extension TimeSelectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeSlots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TimeSelectionCollectionViewCell = timeSelectionCollectionView.dequeueReusableCell(withReuseIdentifier: "TimeSelectionCollectionViewCell", for: indexPath) as! TimeSelectionCollectionViewCell
        cell.timeLbl.text = "\(timeSlots[indexPath.row])"
        return cell
    }
}

extension TimeSelectionVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let spacing: CGFloat = 8
        let totalSpacing: CGFloat = (2 * spacing)
        return CGSize(width: (timeSelectionCollectionView.frame.width/4)-16, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 35, left: 8, bottom: 20, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
