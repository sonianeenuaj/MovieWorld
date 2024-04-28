//
//  MoviesTableViewCellViewModel.swift
//  Movie App
//
//  Created by Sonia Neenu on 25/04/24.
//

protocol MoviesTableViewCellDelegate: AnyObject {
	func setImage(value: String?)
	func setTitle(value: String?)
	func setRating(value: String?)
}

import Foundation

final class MoviesTableViewCellViewModel {
	
	private var moviesList: MovieList?
	weak var delegate: MoviesTableViewCellDelegate?
	
	init(list: MovieList?) {
		moviesList = list
	}
	
	//Update cell delegates
	func updateCellData() {
		delegate?.setImage(value: moviesList?.movieIcon)
		delegate?.setTitle(value: moviesList?.name)
		delegate?.setRating(value: moviesList?.ratings)
	}
	
}
