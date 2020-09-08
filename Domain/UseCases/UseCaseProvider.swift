//
//  UseCaseProvider.swift
//  Domain
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation

public protocol UseCaseProvider {
    func makeAdvertisementsUseCase() -> AdvertisementsUseCase
}
