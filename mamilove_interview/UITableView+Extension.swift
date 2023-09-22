//
//  UITableView+Extension.swift
//  mamilove_interview
//
//  Created by Hsueh Peng Tseng on 2023/9/22.
//

import UIKit

extension UITableView {
	func register<T: UITableViewCell>(_ cell: T.Type) {
		register(cell, forCellReuseIdentifier: String(describing: T.self))
	}
	
	func dequeue<T: UITableViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> UITableViewCell {
		let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath)
		
		if let cell = cell as? T {
			return cell
		}
		
		return UITableViewCell()
	}
}
