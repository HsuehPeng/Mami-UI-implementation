//
//  CheckoutInfoLoader.swift
//  mamilove_interview
//
//  Created by Hsueh Peng Tseng on 2023/9/23.
//

import Foundation

protocol CheckoutInfoLoader {
	typealias LoadResult = Result<CheckoutInfo, Error>
	func load(completion: @escaping (LoadResult) -> Void)
}
