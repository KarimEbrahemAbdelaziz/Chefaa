//
//  HomeViewController.swift
//  Chefaa
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa
import SkeletonView
import Kingfisher

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var sliderImage: UIImageView!
    @IBOutlet private weak var newOffersCollectionView: UICollectionView!
    @IBOutlet private weak var allCategoriesCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    private let newOfferCollectionViewItemSize = CGSize(width: 200, height: 110)
    private let allCategoreisCollectionViewItemSize = CGSize(width: 60, height: 100)
    private let sliderImageCornerRadius: CGFloat = 16.0
    private let disposeBag = DisposeBag()
    
    var viewModel: HomeViewModel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIComponents()
        bindViewModel()
    }
    
    // MARK: - Private Functions
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let input = HomeViewModel.Input(trigger: Driver.merge(viewWillAppear))
        let output = viewModel.transform(input: input)
        
        output.homeAds
            .drive(onNext: { [weak self] (homeAds: (sliders: [SliderItemViewModel], subCategories: [SubCategoryItemViewModel], brands: [BrandItemViewModel], bestSellingItems: [BestSellingItemViewModel], landingPages: [LandingPageItemViewModel])) in
                
                self?.sliderImage.kf.setImage(with: homeAds.sliders.first?.image)
                self?.populateNewOffersCollectionView(with: homeAds.landingPages)
                self?.populateAllCategoriesCollectionView(with: homeAds.subCategories)
            })
            .disposed(by: disposeBag)
        
        output.fetching
            .drive(onNext: { [weak self] isFetching in
                switch isFetching {
                case true:
                    self?.view.showAnimatedGradientSkeleton()
                case false:
                    self?.view.hideSkeleton()
                }
            })
            .disposed(by: disposeBag)
    }
    
}

// MARK: - CollectionViews Data Sources

extension HomeViewController {
    private func populateNewOffersCollectionView(with landingPages: [LandingPageItemViewModel]) {
        Observable.just(landingPages)
            .bind(to: self.newOffersCollectionView.rx.items(cellIdentifier: NewOfferCollectionViewCell.reuseID, cellType: NewOfferCollectionViewCell.self)) { (row, element, cell) in
                cell.configure(viewModel: element)
        }
        .disposed(by: self.disposeBag)
    }
    
    private func populateAllCategoriesCollectionView(with subCategories: [SubCategoryItemViewModel]) {
        Observable.just(subCategories)
            .bind(to: self.allCategoriesCollectionView.rx.items(cellIdentifier: CategoryCollectionViewCell.reuseID, cellType: CategoryCollectionViewCell.self)) { (row, element, cell) in
                cell.configure(viewModel: element)
        }
        .disposed(by: self.disposeBag)
    }
}

// MARK: - UI Components Configurations

extension HomeViewController {
    private func setupUIComponents() {
        configureSliderImage()
        registerCollectionViewCells()
    }
    
    private func configureSliderImage() {
        sliderImage.layer.cornerRadius = sliderImageCornerRadius
    }
    
    private func registerCollectionViewCells() {
        newOffersCollectionView.register(UINib(nibName: "NewOfferCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewOfferCollectionViewCell")
        allCategoriesCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
    
    private func sizeForCollectionViewItem(collectionView: UICollectionView) -> CGSize {
        if collectionView == newOffersCollectionView {
            return newOfferCollectionViewItemSize
        } else if collectionView == allCategoriesCollectionView {
            return allCategoreisCollectionViewItemSize
        }
        return CGSize.zero
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        sizeForCollectionViewItem(collectionView: collectionView)
    }
}
