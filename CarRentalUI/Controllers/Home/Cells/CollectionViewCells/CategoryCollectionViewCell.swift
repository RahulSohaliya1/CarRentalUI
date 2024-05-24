//
//  CategoryCollectionViewCell.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 17/07/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryImgView: UIImageView!
    @IBOutlet weak var categoryNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeCell()
    }
    
    private func customizeCell() {
        categoryView.layer.cornerRadius = 5
        categoryView.layer.borderWidth = 1
        categoryView.layer.borderColor = UIColor.systemGray4.cgColor
    }
}
