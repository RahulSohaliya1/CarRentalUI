//
//  CarDetailsTableViewCell.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 18/07/23.
//

import UIKit
import Cosmos

class CarDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var medalBadgeImgView: UIImageView!
    @IBOutlet weak var carNameLbl: UILabel!
    @IBOutlet weak var carImgView: UIImageView!
    @IBOutlet weak var foxRentACarImgView: UIImageView!
    @IBOutlet weak var readMoreBtn: UIButton!
    @IBOutlet weak var bookBtn: UIButton!
    @IBOutlet weak var MoneyLbl: UILabel!
    @IBOutlet weak var reviewsAndRatingLbl: UILabel!
    @IBOutlet weak var attributeLbl: UILabel!
    @IBOutlet weak var ratingDisplayLbl: UILabel!
    @IBOutlet weak var reviewsView: UIView!
    @IBOutlet weak var reviewBtn: UIButton!
    @IBOutlet weak var reviewNumLbl: UILabel!
    @IBOutlet weak var engineProgressBar: UIProgressView!
    @IBOutlet weak var safetyProgressBar: UIProgressView!
    @IBOutlet weak var TripComputerProgressBar: UIProgressView!
    @IBOutlet weak var comfortProgressBar: UIProgressView!
    @IBOutlet weak var tripProgressBar: UIProgressView!
    @IBOutlet weak var cosmosView: CosmosView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookBtn.layer.cornerRadius = 5
        cosmosView.isUserInteractionEnabled = false
        cosmosView.didTouchCosmos = didTouchCosmos
        cosmosView.didFinishTouchingCosmos = didFinishTouchingCosmos
        updateRating(requiredRating: nil)
    }

    private func updateRating(requiredRating: Double?) {
        var newRatingValue: Double = 3.5
        
        if let nonEmptyRequiredRating = requiredRating {
            newRatingValue = nonEmptyRequiredRating
        } else { }
        
        cosmosView.rating = newRatingValue
        self.ratingDisplayLbl.text = CarDetailsTableViewCell.formatValue(newRatingValue)
    }
    
    private class func formatValue(_ value: Double) -> String {
        return String(format: "%.2f", value)
    }
    
    private func didTouchCosmos(_ rating: Double) {
        ratingDisplayLbl.text = CarDetailsTableViewCell.formatValue(rating)
        updateRating(requiredRating: rating)
        ratingDisplayLbl.textColor = UIColor(red: 133/255, green: 116/255, blue: 154/255, alpha: 1)
    }
    
    private func didFinishTouchingCosmos(_ rating: Double) {
        self.ratingDisplayLbl.text = CarDetailsTableViewCell.formatValue(rating)
        ratingDisplayLbl.textColor = UIColor(red: 183/255, green: 186/255, blue: 204/255, alpha: 1)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
