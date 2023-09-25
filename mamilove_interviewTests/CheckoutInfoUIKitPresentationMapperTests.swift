//
//  CheckoutInfoUIKitPresentationMapper.swift
//  mamilove_interviewTests
//
//  Created by Hsueh Peng Tseng on 2023/9/25.
//

import XCTest
@testable import mamilove_interview

final class CheckoutInfoUIKitPresentationMapperTests: XCTestCase {
	
	func test_mapCheckoutInfo_deliverCorrectCheckoutInfo() {
		let sut = makeSut()
		let anyCheckoutInfo = anyCheckoutInfo()
		let expectedResult = expectedResultStub()
		
		let result = sut.mapCheckoutInfo(for: anyCheckoutInfo)
		
		for i in 0..<result.count {
			let retrievedVM = result[i]
			let expectedVM = expectedResult[i]
			
			XCTAssertEqual(retrievedVM.title, expectedVM.title)
			XCTAssertEqual(retrievedVM.subTitle.string, expectedVM.subTitle.string)
			XCTAssertEqual(retrievedVM.isArrowButtonHidden, expectedVM.isArrowButtonHidden)
		}
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> CheckoutInfoUIKitPresentationMapper {
		let sut = CheckoutInfoUIKitPresentationMapper()
		return sut
	}
	
	private func anyCheckoutInfo() -> CheckoutInfo {
		let payments = Payments(title: "付款", options: [
			PaymentsOption(title: "信用卡", icon: ""),
			PaymentsOption(title: "LINE PAY", icon: ""),
			PaymentsOption(title: "ATM", icon: ""),
			PaymentsOption(title: "貨到付款", icon: ""),
		])
		
		let shipping = Shippings(title: "配送", options: [
			ShippingsOption(isConvenienceStore: false, freeThreshold: 999, title: "宅配", shippingFee: 90),
			ShippingsOption(isConvenienceStore: true, freeThreshold: 999, title: "全家", shippingFee: 90),
			ShippingsOption(isConvenienceStore: true, freeThreshold: 999, title: "萊爾富", shippingFee: 90),
			ShippingsOption(isConvenienceStore: true, freeThreshold: 999, title: "OK Mart", shippingFee: 90),
		])
		
		let preOrder = PreOrder(title: "預購", description: "付款後 14 ~ 21 個工作天")
		
		return CheckoutInfo(payments: payments, shippings: shipping, preOrder: preOrder)
	}
	
	private func expectedResultStub() -> [InfoCellViewModel] {
		return [
			InfoCellViewModel(title: "付款", subTitle: NSAttributedString(string: "信用卡・LINE PAY・ATM・貨到付款"), isArrowButtonHidden: false),
			InfoCellViewModel(title: "配送", subTitle: NSAttributedString(string: "宅配  滿$999免運\n全家  滿$999免運"), isArrowButtonHidden: false),
			InfoCellViewModel(title: "預購", subTitle: NSAttributedString(string: "付款後 14 ~ 21 個工作天"), isArrowButtonHidden: true)
		]
	}
	
}
