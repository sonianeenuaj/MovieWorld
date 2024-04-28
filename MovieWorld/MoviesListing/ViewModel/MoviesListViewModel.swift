//
//  MoviesListViewModel.swift
//  Movie App
//
//  Created by Sonia Neenu on 25/04/24.
//

import Foundation

protocol MoviesListViewModelDelegate: AnyObject {
	func reloadData()
}

final class MoviesListViewModel {
	
	var moviesData: MovieListResponse?
	var moviesList: [MovieList]?
	weak var delegate: MoviesListViewModelDelegate?
	var filterNameArray: [String]?
	var selectedFilterIndex: Int = 0
	var searchText: String = ""
	var filterMoviesByCategory: [String: [MovieList]] = [:]
	var selectedCategory: String = "All"
	
	func getDataFromServer() {
		MoviesAPIClient.shared.fetchData{ [weak self] result in
			switch result {
				case .success(let response):
					self?.moviesData = response
					self?.moviesList = self?.getMovieListData().0
					self?.filterNameArray = self?.getMovieListData().1
					self?.filterMoviesByCategory[self?.selectedCategory ?? ""] = self?.getMovieListData().0
					DispatchQueue.main.async {
						self?.delegate?.reloadData()
					}
				case .failure(let error):
					print("Error fetching data: \(error)")
			}
		}
	}
	
	func getMovieListData() -> ([MovieList]?, [String]?) {
		var allMoview: [MovieList] = []
		var filterArray: [String] = ["All"]
		guard let data = moviesData?.data else { return ([], [])}
		for movie in data {
			if let categoryMovies = movie.movieList, let categories = movie.movieCategory {
				allMoview.append(contentsOf: categoryMovies)
				filterArray.append(categories)
			}
		}
		return (allMoview, filterArray)
	}
	
	func getCount() -> Int {
		return moviesList?.count ?? 0
	}
	
	func getCellViewModel(index: Int?) -> MoviesTableViewCellViewModel {
		return MoviesTableViewCellViewModel(list: moviesList?[index ?? 0])
	}
	
	func getFilterArrayCount() -> Int {
		return filterNameArray?.count ?? 0
	}
	
	func filterByCategory(category: String) {
		selectedCategory = category
		guard let categoryData = moviesData?.data else { return }
		if let filterdMovies = filterMoviesByCategory[category] {
			moviesList = filterdMovies
		} else {
			if category == "All" {
				moviesList = getMovieListData().0
			} else {
				for data in categoryData {
					if data.movieCategory == category {
						moviesList = data.movieList
					}
				}
			}
			filterMoviesByCategory[category] = moviesList
		}
		if !(searchText.isEmpty) {
			searchData(with: searchText)
		} else {
			delegate?.reloadData()
		}
	}
	
	func setSelectedFilterIndex(index: Int) {
		selectedFilterIndex = index
	}
	
	func searchData(with text: String) {
		searchText = text
		if text.isEmpty {
			moviesList = filterMoviesByCategory[selectedCategory]
		} else {
			moviesList = moviesList?.filter{ movie in
				if let name = movie.name {
					return name.lowercased().contains(text.lowercased())
				}
				return false
			}
		}
		delegate?.reloadData()
	}
	
	func getDetailCellViewModel(index: Int?) -> MoviesDetailsViewModel? {
		return MoviesDetailsViewModel(data: moviesList?[index ?? 0])
	}
	
}
