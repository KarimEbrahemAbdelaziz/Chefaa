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

class HomeViewController: UIViewController {

    private let disposeBag = DisposeBag()
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let input = HomeViewModel.Input(trigger: Driver.merge(viewWillAppear))
        let output = viewModel.transform(input: input)
        
        //Bind Posts to UITableView
//        output.posts
//            .drive(tableView.rx.items(cellIdentifier: PostTableViewCell.reuseID,
//        cellType: PostTableViewCell.self)) { tv, viewModel, cell in
//            cell.bind(viewModel)
//        }.disposed(by: disposeBag)
        output.homeAds
            .drive(onNext: { (homeAds: (sliders: [SliderItemViewModel], subCategories: [SubCategoryItemViewModel], brands: [BrandItemViewModel], bestSellingItems: [BestSellingItemViewModel], landingPages: [LandingPageItemViewModel])) in
                print(homeAds.sliders.count)
        })
        .disposed(by: disposeBag)
        
        //Connect Create Post to UI
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
