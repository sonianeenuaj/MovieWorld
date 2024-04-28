//
//  FavouriteMoviesViewModel.swift
//  Movie App
//
//  Created by Sonia Neenu on 25/04/24.
//

import Foundation

protocol FavouriteMoviesViewModelDelegate: AnyObject {
	func didupdateFavMovies(data: [MovieList])
}

final class FavouriteMoviesViewModel {
	
	weak var delegate: FavouriteMoviesViewModelDelegate?
	var favouriteMovies: [MovieList]?
	
	init () {
		favouriteMovies = loadFavMovies()
	}
	
	func loadFavMovies() -> [MovieList] {
		if let data = UserDefaults.standard.data(forKey: "favouriteMovies") {
			let favMovies = (try? JSONDecoder().decode([MovieList].self, from: data)) ?? []
			delegate?.didupdateFavMovies(data: favMovies)
			return favMovies
		}
		return []
	}
	
	func getRowCount() -> Int {
		return favouriteMovies?.count ?? 0
	}
	
	func getCellViewModel(index: Int?) -> MoviesTableViewCellViewModel {
		return MoviesTableViewCellViewModel(list: favouriteMovies?[index ?? 0])
	}
	
	func getDetailCellViewModel(index: Int?) -> MoviesDetailsViewModel? {
		return MoviesDetailsViewModel(data: favouriteMovies?[index ?? 0])
	}
	
}
