//
//  BrandCollectionViewCell.swift
//  Chefaa
//
//  Created by KarimEbrahem on 9/10/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import UIKit

class BrandCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageContainerView.layer.cornerRadius = 8.0
        imageContainerView.layer.borderWidth = 0.5
        imageContainerView.layer.borderColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00).cgColor
    }
    
    func configure(viewModel: BrandItemViewModel) {
        imageView.kf.setImage(with: viewModel.image)
    }

}
