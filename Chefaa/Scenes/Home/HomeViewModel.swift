//
//  HomeViewModel.swift
//  Chefaa
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

// MARK: - TypeAlias

typealias HomeComponentsViewModelsTypeAlias = (sliders: [SliderItemViewModel], subCategories: [SubCategoryItemViewModel], brands: [BrandItemViewModel], bestSellingItems: [BestSellingItemViewModel], landingPages: [LandingPageItemViewModel])

final class HomeViewModel: ViewModelType {
    
    // MARK: - ViewModel Inputs
    
    struct Input {
        let trigger: Driver<Void>
    }
    
    // MARK: - ViewModel Outputs
    
    struct Output {
        let fetching: Driver<Bool>
        let homeAds: Driver<HomeComponentsViewModelsTypeAlias>
        let error: Driver<Error>
    }
    
    // MARK: - Properties
    
    private let useCase: AdvertisementsUseCase
    private let navigator: HomeNavigator
    
    // MARK: - Init
    
    init(useCase: AdvertisementsUseCase, navigator: HomeNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    // MARK: - ViewModel Transformation
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let homeComponents = input.trigger.flatMapLatest {
            return self.useCase.homeComponents()
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .map { (homeItems: HomeComponentsTypeAlias) -> HomeComponentsViewModelsTypeAlias in
                    
                    let sliderItemsViewModels = homeItems.sliders.map { SliderItemViewModel(with: $0) }
                    let subCategoriesItemsViewModels = homeItems.subCategories.map { SubCategoryItemViewModel(with: $0) }
                    let brandsItemsViewModels = homeItems.brands.map { BrandItemViewModel(with: $0) }
                    let bestSellingItemsViewModels = homeItems.items.map { BestSellingItemViewModel(with: $0) }
                    let landingPagesItemsViewModels = homeItems.landingPages.map { LandingPageItemViewModel(with: $0) }
                    
                    return (sliders: sliderItemsViewModels,
                            subCategories: subCategoriesItemsViewModels,
                            brands: brandsItemsViewModels,
                            bestSellingItems: bestSellingItemsViewModels,
                            landingPages: landingPagesItemsViewModels)
            }
        }
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        return Output(fetching: fetching,
                      homeAds: homeComponents,
                      error: errors)
    }
}
