//
//  NewOfferCollectionViewCell.swift
//  Chefaa
//
//  Created by KarimEbrahem on 9/10/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import UIKit
import Kingfisher

class NewOfferCollectionViewCell: UICollectionViewCell, Reusable {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 8.0
    }
    
    func configure(viewModel: LandingPageItemViewModel) {
        imageView.kf.setImage(with: viewModel.image)
    }
    
}

