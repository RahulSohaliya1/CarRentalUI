//
//  TimeSelectionCollectionViewCell.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 19/07/23.
//

import UIKit

class TimeSelectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timeView.layer.cornerRadius = 5
    }
}
