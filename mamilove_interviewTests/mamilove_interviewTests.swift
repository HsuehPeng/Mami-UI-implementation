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
	
	var checkoutInfoLoadError: Error?
	
	func loadCheckoutInfo() {
		checkoutInfoLoader.load { [weak self] result in
			switch result {
			case .failure(let error):
				self?.checkoutInfoLoadError = error
			default:
				break
			}
		}
	}
}

final class mamilove_interviewTests: XCTestCase {
	
	func test_loadCheckoutInfo_loaderDidCallLoad() {
		let (sut, loader) = makeSut()
		
		sut.loadCheckoutInfo()
		
		XCTAssertTrue(loader.didCallLoad)
	}
	
	func test_loadCheckoutInfo_getLoadedErrorWhenLoaderFailToLoadCheckoutInfo() {
		let (sut, loader) = makeSut()
		let anyError = CheckoutInfoLoaderSpy.Error.loadError
		
		sut.loadCheckoutInfo()
		
		loader.completeLoadWith(.failure(anyError))
		
		XCTAssertEqual(sut.checkoutInfoLoadError as? CheckoutInfoLoaderSpy.Error, anyError)
	}

	// MARK: - Helpers
	
	private func makeSut() -> (HomeViewControllerViewModel, CheckoutInfoLoaderSpy) {
		let checkoutInfoLoader = CheckoutInfoLoaderSpy()
		let sut = HomeViewControllerViewModel(checkoutInfoLoader: checkoutInfoLoader)
		return (sut, checkoutInfoLoader)
	}
							   
	class CheckoutInfoLoaderSpy: CheckoutInfoLoader {
		var didCallLoad = false
		var completions = [(LoadResult) -> Void]()
		
		enum Error: Swift.Error {
			case loadError
		}
		
		func load(completion: @escaping (LoadResult) -> Void) {
			didCallLoad = true
			completions.append(completion)
		}
		
		func completeLoadWith(_ result: LoadResult, at index: Int = 0) {
			completions[index](result)
		}
	}

}
