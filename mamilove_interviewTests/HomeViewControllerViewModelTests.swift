//
//  mamilove_interviewTests.swift
//  mamilove_interviewTests
//
//  Created by Hsueh Peng Tseng on 2023/9/22.
//

import XCTest
@testable import mamilove_interview

final class HomeViewControllerViewModelTests: XCTestCase {
	
	func test_loadCheckoutInfo_loaderDidCallLoad() {
		let (sut, loader, _) = makeSut()
		
		sut.loadCheckoutInfo()
		
		XCTAssertTrue(loader.didCallLoad)
	}
	
	func test_loadCheckoutInfo_getLoadedErrorWhenLoaderFailToLoadCheckoutInfo() {
		let (sut, loader, _) = makeSut()
		let anyError = CheckoutInfoLoaderSpy.Error.loadError
		
		sut.loadCheckoutInfo()
		
		loader.completeLoadWith(.failure(anyError))
		
		XCTAssertEqual(sut.checkoutInfoLoadError as? CheckoutInfoLoaderSpy.Error, anyError)
	}
	
	func test_loadCheckoutInfo_getCheckoutInfoWhenLoaderLoadsCheckoutInfo() {
		let (sut, loader, _) = makeSut()
		let anyCheckoutInfo = anyCheckoutInfo()
		
		sut.loadCheckoutInfo()
		
		loader.completeLoadWith(.success(anyCheckoutInfo))
		
		XCTAssertNotNil(sut.checkoutInfo)
	}
	
	func test_updateCheckoutInfoCellViewModels_AfterCheckoutInfoHasBeenLoaded_mapCheckoutInfoCallCount() {
		let (sut, _, checkoutInfoMapper) = makeSut()
		let anyCheckoutInfo = anyCheckoutInfo()
		
		sut.checkoutInfo = anyCheckoutInfo
		sut.checkoutInfo = nil
		
		XCTAssertEqual(checkoutInfoMapper.mapCheckoutInfoCallCount, 2)
	}
	
	func test_loadCheckoutInfo_updateCheckoutInfoCellViewModelsAfterCheckoutInfoHasBeenLoaded() {
		let (sut, loader, checkoutInfoMapper) = makeSut()
		let anyCheckoutInfo = anyCheckoutInfo()
		let expectedCheckoutInfoCellViewModels = anyCheckoutInfoCellViewModels()
		
		sut.loadCheckoutInfo()
		
		loader.completeLoadWith(.success(anyCheckoutInfo))
		
		XCTAssertEqual(sut.checkoutInfoCellViewModels.value.count, checkoutInfoMapper.mapCheckoutInfo(for: anyCheckoutInfo).count)

		for i in 0..<sut.checkoutInfoCellViewModels.value.count {
			let retrievedVM = sut.checkoutInfoCellViewModels.value[i]
			let expectedVM = expectedCheckoutInfoCellViewModels[i]
			XCTAssertEqual(retrievedVM.title, expectedVM.title)
			XCTAssertEqual(retrievedVM.subTitle.string, expectedVM.subTitle.string)
			XCTAssertEqual(retrievedVM.isArrowButtonHidden, expectedVM.isArrowButtonHidden)
		}
	}

	// MARK: - Helpers
	
	private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (HomeViewControllerViewModel, CheckoutInfoLoaderSpy, CheckoutInfoPresentationMapperMock) {
		let checkoutInfoLoader = CheckoutInfoLoaderSpy()
		let checkoutInfoPresentationMapperMock = CheckoutInfoPresentationMapperMock()
		let sut = HomeViewControllerViewModel(checkoutInfoLoader: checkoutInfoLoader, checkoutInfoCellViewModelMapper: checkoutInfoPresentationMapperMock)
		
		trackForMemoryLeaks(checkoutInfoLoader, file: file, line: line)
		trackForMemoryLeaks(sut, file: file, line: line)
		
		return (sut, checkoutInfoLoader, checkoutInfoPresentationMapperMock)
	}
	
	private func anyCheckoutInfo() -> CheckoutInfo {
		let payments = Payments(title: "Payment", options: [])
		let shippings = Shippings(title: "Shipping", options: [])
		let preOrder = PreOrder(title: "PreOrder", description: "")
		
		return CheckoutInfo(payments: payments, shippings: shippings, preOrder: preOrder)
	}
	
	private func anyCheckoutInfoCellViewModels() -> [InfoCellViewModel] {
		return [
			InfoCellViewModel(title: "Payment", subTitle: NSAttributedString(string: ""), isArrowButtonHidden: false),
			InfoCellViewModel(title: "Shipping", subTitle: NSAttributedString(string: ""), isArrowButtonHidden: false),
			InfoCellViewModel(title: "PreOrder", subTitle: NSAttributedString(string: ""), isArrowButtonHidden: true),
		]
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
	
	class CheckoutInfoPresentationMapperMock: CheckoutInfoPresentationMapper {
		var mapCheckoutInfoCallCount = 0
		
		func mapCheckoutInfo(for checkoutInfo: CheckoutInfo?) -> [InfoCellViewModel] {
			mapCheckoutInfoCallCount += 1
			return []
		}
	}

}
