//
//  mamilove_interviewTests.swift
//  mamilove_interviewTests
//
//  Created by Hsueh Peng Tseng on 2023/9/22.
//

import XCTest
@testable import mamilove_interview

protocol CheckoutInfoLoader {
	typealias LoadResult = Result<CheckoutInfo, Error>
	func load(completion: @escaping (LoadResult) -> Void)
}

class HomeViewControllerViewModel {
	let checkoutInfoLoader: CheckoutInfoLoader
	
	init(checkoutInfoLoader: CheckoutInfoLoader) {
		self.checkoutInfoLoader = checkoutInfoLoader
	}
	
	func loadCheckoutInfo() {
		checkoutInfoLoader.load { result in
			
		}
	}
}

final class mamilove_interviewTests: XCTestCase {
	
	func test_loadCheckoutInfo_loaderDidCallLoad() {
		let (sut, loader) = makeSut()
		
		sut.loadCheckoutInfo()
		
		XCTAssertTrue(loader.didCallLoad)
	}

	// MARK: - Helpers
	
	private func makeSut() -> (HomeViewControllerViewModel, CheckoutInfoLoaderSpy) {
		let checkoutInfoLoader = CheckoutInfoLoaderSpy()
		let sut = HomeViewControllerViewModel(checkoutInfoLoader: checkoutInfoLoader)
		return (sut, checkoutInfoLoader)
	}
							   
	class CheckoutInfoLoaderSpy: CheckoutInfoLoader{
		var didCallLoad = false
		
		func load(completion: @escaping (LoadResult) -> Void) {
			didCallLoad = true
		}
	}

}
