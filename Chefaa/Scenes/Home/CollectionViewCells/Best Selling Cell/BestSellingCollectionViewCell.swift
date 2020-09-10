//
//  BestSellingCollectionViewCell.swift
//  Chefaa
//
//  Created by KarimEbrahem on 9/10/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import UIKit
import Kingfisher

class BestSellingCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var itemTitleLabel: UILabel!
    @IBOutlet private weak var itemPriceLabel: UILabel!
    @IBOutlet private weak var addToCartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageContainerView.layer.cornerRadius = 8.0
        imageContainerView.layer.borderWidth = 0.5
        imageContainerView.layer.borderColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00).cgColor
        
        addToCartButton.layer.cornerRadius = 8.0
        addToCartButton.backgroundColor = UIColor(red: 0.00, green: 0.80, blue: 0.49, alpha: 1.00)
    }
    
    func configure(viewModel: BestSellingItemViewModel) {
        itemImageView.kf.setImage(with: viewModel.image)
        itemTitleLabel.text = viewModel.title
        itemPriceLabel.text = viewModel.price
    }

}
