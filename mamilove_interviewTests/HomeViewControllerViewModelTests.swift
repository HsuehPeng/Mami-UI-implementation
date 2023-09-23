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

struct CheckoutInfoCellViewModel {
	let title: String
	let subTitle: NSAttributedString
	let isArrowButtonHidden: Bool
}

class HomeViewControllerViewModel {
	private let checkoutInfoLoader: CheckoutInfoLoader
	
	init(checkoutInfoLoader: CheckoutInfoLoader) {
		self.checkoutInfoLoader = checkoutInfoLoader
	}
	
	var checkoutInfo: CheckoutInfo? {
		didSet {
			self.checkoutInfoCellViewModels = mapCheckoutInfoCellViewModels(for: checkoutInfo)
		}
	}
	var checkoutInfoLoadError: Error?
	var checkoutInfoCellViewModels = [CheckoutInfoCellViewModel]()
	
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
	
	private func mapCheckoutInfoCellViewModels(for checkoutInfo: CheckoutInfo?) -> [CheckoutInfoCellViewModel] {
		guard let checkoutInfo = checkoutInfo else { return [] }
		return [mapPayment(for: checkoutInfo.payments), mapShippings(for: checkoutInfo.shippings), mapPreOrder(for: checkoutInfo.preOrder)]
	}
	
	private func mapPayment(for payment: Payments) -> CheckoutInfoCellViewModel {
		let title = payment.title
		
		let subTitleAttribute: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 12),
			.foregroundColor: UIColor.label
		]
		let subTitleString = payment.options.map { option in
			option.title
		}.joined(separator: "・")
		
		let subTitle = NSAttributedString(string: subTitleString, attributes: subTitleAttribute)
		
		return CheckoutInfoCellViewModel(title: title, subTitle: subTitle, isArrowButtonHidden: false)
	}
	
	private func mapShippings(for shippings: Shippings) -> CheckoutInfoCellViewModel {
		let title = shippings.title
		
		let subTitleFirstAttribute: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 12),
			.foregroundColor: UIColor.label
		]
		
		let subTitleSecondAttribute: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 10),
			.foregroundColor: UIColor.secondaryLabel
		]
		
		let subTitle = NSMutableAttributedString(string: "")
		
		for i in 0..<shippings.options.count {
			if i > 1 { break }
			let option = shippings.options[i]
			let optionTitle = NSMutableAttributedString(string: option.title, attributes: subTitleFirstAttribute)
			let optionFreeThresholdString = NSAttributedString(string: "滿$\(option.freeThreshold)免運\n", attributes: subTitleSecondAttribute)
			optionTitle.append(optionFreeThresholdString)
			subTitle.append(optionTitle)
		}

		return CheckoutInfoCellViewModel(title: title, subTitle: subTitle, isArrowButtonHidden: false)
	}
	
	private func mapPreOrder(for preOrder: PreOrder) -> CheckoutInfoCellViewModel {
		let title = preOrder.title
		
		let subTitleAttribute: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 12),
			.foregroundColor: UIColor.label
		]
		
		let subTitle = NSAttributedString(string: preOrder.description, attributes: subTitleAttribute)

		return CheckoutInfoCellViewModel(title: title, subTitle: subTitle, isArrowButtonHidden: true)
	}
	
}

final class HomeViewControllerViewModelTests: XCTestCase {
	
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
	
	func test_loadCheckoutInfo_getCheckoutInfoWhenLoaderLoadsCheckoutInfo() {
		let (sut, loader) = makeSut()
		let anyCheckoutInfo = anyCheckoutInfo()
		
		sut.loadCheckoutInfo()
		
		loader.completeLoadWith(.success(anyCheckoutInfo))
		
		XCTAssertNotNil(sut.checkoutInfo)
	}
	
	func test_loadCheckoutInfo_updateCheckoutInfoCellViewModelsAfterCheckoutInfoHasBeenLoaded() {
		let (sut, loader) = makeSut()
		let anyCheckoutInfo = anyCheckoutInfo()
		let expectedCheckoutInfoCellViewModels = anyCheckoutInfoCellViewModels()
		
		sut.loadCheckoutInfo()
		
		loader.completeLoadWith(.success(anyCheckoutInfo))
		
		XCTAssertFalse(sut.checkoutInfoCellViewModels.isEmpty, "checkoutInfoCellViewModels should not be empty after checkoutInfo has been loaded")

		for i in 0..<sut.checkoutInfoCellViewModels.count {
			let retrievedVM = sut.checkoutInfoCellViewModels[i]
			let expectedVM = expectedCheckoutInfoCellViewModels[i]
			XCTAssertEqual(retrievedVM.title, expectedVM.title)
			XCTAssertEqual(retrievedVM.subTitle.string, expectedVM.subTitle.string)
			XCTAssertEqual(retrievedVM.isArrowButtonHidden, expectedVM.isArrowButtonHidden)
		}
	}

	// MARK: - Helpers
	
	private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (HomeViewControllerViewModel, CheckoutInfoLoaderSpy) {
		let checkoutInfoLoader = CheckoutInfoLoaderSpy()
		let sut = HomeViewControllerViewModel(checkoutInfoLoader: checkoutInfoLoader)
		
		trackForMemoryLeaks(checkoutInfoLoader, file: file, line: line)
		trackForMemoryLeaks(sut, file: file, line: line)
		
		return (sut, checkoutInfoLoader)
	}
	
	private func anyCheckoutInfo() -> CheckoutInfo {
		let payments = Payments(title: "Payment", options: [])
		let shippings = Shippings(title: "Shipping", options: [])
		let preOrder = PreOrder(title: "PreOrder", description: "")
		
		return CheckoutInfo(payments: payments, shippings: shippings, preOrder: preOrder)
	}
	
	private func anyCheckoutInfoCellViewModels() -> [CheckoutInfoCellViewModel] {
		return [
			CheckoutInfoCellViewModel(title: "Payment", subTitle: NSAttributedString(string: ""), isArrowButtonHidden: false),
			CheckoutInfoCellViewModel(title: "Shipping", subTitle: NSAttributedString(string: ""), isArrowButtonHidden: false),
			CheckoutInfoCellViewModel(title: "PreOrder", subTitle: NSAttributedString(string: ""), isArrowButtonHidden: true),
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

}
