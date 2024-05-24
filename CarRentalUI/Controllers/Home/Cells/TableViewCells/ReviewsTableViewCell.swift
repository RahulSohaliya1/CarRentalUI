//
//  ReviewsTableViewCell.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 19/07/23.
//

import UIKit
import Cosmos

class ReviewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewsView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var cosmosRatingView: CosmosView!
    @IBOutlet weak var reviewMsgLbl: UILabel!
    @IBOutlet weak var showTimingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cosmosRatingView.isUserInteractionEnabled = false
        cosmosRatingView.didTouchCosmos = didTouchCosmos
        cosmosRatingView.didFinishTouchingCosmos = didFinishTouchingCosmos
        updateRating(requiredRating: nil)
    }
    
    private func updateRating(requiredRating: Double?) {
        var newRatingValue: Double = 1.5
        
    if let nonEmptyRequiredRating = requiredRating {
        newRatingValue = nonEmptyRequiredRating
    } else { }

    cosmosRatingView.rating = newRatingValue
  }
    
    private class func formatValue(_ value: Double) -> String {
        return String(format: "%.2f", value)
    }
    
    private func didTouchCosmos(_ rating: Double) {
        updateRating(requiredRating: rating)
    }
    
    private func didFinishTouchingCosmos(_ rating: Double) { }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
