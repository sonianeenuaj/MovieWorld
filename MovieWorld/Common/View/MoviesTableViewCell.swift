//
//  MoviesTableViewCell.swift
//  Movie App
//
//  Created by Sonia Neenu on 24/04/24.
//

import Foundation
import UIKit

final class MoviesTableViewCell: UITableViewCell {
	
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var iconImageView: UIImageView!
	@IBOutlet private weak var ratingLabel: UILabel!
	@IBOutlet private weak var parentView: UIView!
	
	var viewModel: MoviesTableViewCellViewModel?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setupUI()
	}
	
	private func setupUI() {
		parentView.layer.borderWidth = 1
		parentView.layer.borderColor = UIColor.gray.cgColor
		parentView.layer.cornerRadius = 4
	}
	
	func configureCell(viewModel: MoviesTableViewCellViewModel?) {
		self.viewModel = viewModel
		viewModel?.delegate = self
		viewModel?.updateCellData()
	}
	
}

extension MoviesTableViewCell: MoviesTableViewCellDelegate {
	
	func setImage(value: String?) {
		guard let urlString = value, let url = URL(string: urlString) else {
			return
		}
		ImageHandler.loadImage(from: url) { [weak self] image in
			guard let self = self else { return }
			self.iconImageView.image = image
		}
	}
	
	func setTitle(value: String?) {
		titleLabel.text = "Movie Name:" + " " + (value ?? "")
	}
	
	func setRating(value: String?) {
		ratingLabel.text = value
	}
	
}
