//
//  MyBookingsTableViewCell.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 19/07/23.
//

import UIKit
import Cosmos

class MyBookingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carNameLbl: UILabel!
    @IBOutlet weak var clockTimingLbl: UILabel!
    @IBOutlet weak var addLocationLbl: UILabel!
    @IBOutlet weak var ratingCosmosView: CosmosView!
    @IBOutlet weak var ratingDisplayLbl: UILabel!
    @IBOutlet weak var statusOrderLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingCosmosView.isUserInteractionEnabled = true
        ratingCosmosView.didTouchCosmos = didTouchCosmos
        ratingCosmosView.didFinishTouchingCosmos = didFinishTouchingCosmos
        updateRating(requiredRating: nil)
    }
    
    private func updateRating(requiredRating: Double?) {
        var newRatingValue: Double = 2.4
        
        if let nonEmptyRequiredRating = requiredRating {
            newRatingValue = nonEmptyRequiredRating
        } else { }
        
        ratingCosmosView.rating = newRatingValue
        self.ratingDisplayLbl.text = MyBookingsTableViewCell.formatValue(newRatingValue)
    }
    
    private class func formatValue(_ value: Double) -> String {
        return String(format: "%.2f", value)
    }
    
    private func didTouchCosmos(_ rating: Double) {
        ratingDisplayLbl.text = MyBookingsTableViewCell.formatValue(rating)
        updateRating(requiredRating: rating)
        ratingDisplayLbl.textColor = UIColor(red: 133/255, green: 116/255, blue: 154/255, alpha: 1)
    }
    
    private func didFinishTouchingCosmos(_ rating: Double) {
        self.ratingDisplayLbl.text = MyBookingsTableViewCell.formatValue(rating)
        ratingDisplayLbl.textColor = UIColor(red: 183/255, green: 186/255, blue: 204/255, alpha: 1)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
