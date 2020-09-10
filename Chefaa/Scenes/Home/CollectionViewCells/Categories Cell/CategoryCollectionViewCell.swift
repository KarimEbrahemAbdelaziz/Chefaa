//
//  CategoryCollectionViewCell.swift
//  Chefaa
//
//  Created by KarimEbrahem on 9/10/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var categoryTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(viewModel: SubCategoryItemViewModel) {
        imageView.kf.setImage(with: viewModel.image)
        categoryTitle.text = viewModel.title
    }

}
