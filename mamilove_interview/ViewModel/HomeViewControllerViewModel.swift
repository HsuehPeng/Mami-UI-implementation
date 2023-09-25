//
//  HomeViewControllerViewModel.swift
//  mamilove_interview
//
//  Created by Hsueh Peng Tseng on 2023/9/23.
//

import UIKit

class HomeViewControllerViewModel {
	private let checkoutInfoLoader: CheckoutInfoLoader
	private let checkoutInfoPresentationMapper: CheckoutInfoPresentationMapper
	
	init(checkoutInfoLoader: CheckoutInfoLoader, checkoutInfoCellViewModelMapper: CheckoutInfoPresentationMapper) {
		self.checkoutInfoLoader = checkoutInfoLoader
		self.checkoutInfoPresentationMapper = checkoutInfoCellViewModelMapper
	}
	
	var checkoutInfo: CheckoutInfo? {
		didSet {
			self.checkoutInfoCellViewModels.value = checkoutInfoPresentationMapper.mapCheckoutInfo(for: checkoutInfo)
		}
	}
	var checkoutInfoLoadError: Error?
	var checkoutInfoCellViewModels = Bindable([InfoCellViewModel]())
	
	func loadCheckoutInfo() {
		checkoutInfoLoader.load { [weak self] result in
			switch result {
			case .failure(let error):
				self?.checkoutInfoLoadError = error
			case .success(let checkoutInfo):
				self?.checkoutInfo = checkoutInfo
			}
		}
	}
	
}
