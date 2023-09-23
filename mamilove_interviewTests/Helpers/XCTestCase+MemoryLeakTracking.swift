//
//  XCTestCase+MemoryLeakTracking.swift
//  mamilove_interviewTests
//
//  Created by Hsueh Peng Tseng on 2023/9/23.
//

import XCTest

extension XCTestCase {
	func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
		addTeardownBlock { [weak instance] in
			XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
		}
	}
}
