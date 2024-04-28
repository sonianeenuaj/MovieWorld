//
//  FilterCollectionViewCell.swift
//  Movie App
//
//  Created by Sonia Neenu on 26/04/24.
//

import Foundation
import UIKit

protocol FilterCollectionViewCellDlegate: AnyObject {
	func filterData(category: String)
}

final class FilterCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var filterLabel: UILabel!
	
	weak var delegate: FilterCollectionViewCellDlegate?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setupUI()
	}
	
	private func setupUI() {
		contentView.layer.cornerRadius = 4
		contentView.layer.borderWidth = 1
		contentView.layer.borderColor = UIColor.darkGray.cgColor
	}
	
	func setText(value: String) {
		filterLabel.text = value
	}
	
	func setData(category: String) {
		delegate?.filterData(category: category)
	}
	
	func setSelection(isSelected: Bool) {
		contentView.backgroundColor = isSelected ? .link : .white
		filterLabel.textColor = isSelected ? .white : .black
		contentView.layer.borderWidth = isSelected ? 0 : 1
	}
	
}
