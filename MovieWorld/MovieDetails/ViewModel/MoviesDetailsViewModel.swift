//
//  MoviesDetailsViewModel.swift
//  Movie App
//
//  Created by Sonia Neenu on 27/04/24.
//

import Foundation
import MapKit

protocol MoviesDetailsViewModelDelegate: AnyObject {
	func setDetails(data: MovieList)
}

final class MoviesDetailsViewModel {
	private var moviesData: MovieList?
	weak var delegate: MoviesDetailsViewModelDelegate?
	var favouriteMoviesArray: [MovieList] = []
	
	init(data: MovieList?){
		moviesData = data
		favouriteMoviesArray = loadFavMovies()
	}
	
	func setData() {
		guard let data = moviesData else { return }
		delegate?.setDetails(data: data)
	}
	
	func setAddTofav() {
		guard let data = moviesData else {return}
		if favouriteMoviesArray.contains(where: {$0.name == data.name}) {
			if let index = favouriteMoviesArray.firstIndex(where: {$0.name == data.name}) {
				favouriteMoviesArray.remove(at: index)
			}
		} else {
			favouriteMoviesArray.append(data)
		}
		saveFavouriteMovies()
	}
	
	private func saveFavouriteMovies() {
		if let encodedData = try? JSONEncoder().encode(favouriteMoviesArray) {
			UserDefaults.standard.set(encodedData, forKey: "favouriteMovies")
		}
	}
	
	func isAddedToFavourite() -> Bool{
		var value = false
		for item in favouriteMoviesArray {
			if item.name == moviesData?.name {
				value = true
			}
		}
		return value
	}
	
	private func loadFavMovies() -> [MovieList] {
		if let data = UserDefaults.standard.data(forKey: "favouriteMovies") {
			let favMovies = (try? JSONDecoder().decode([MovieList].self, from: data)) ?? []
			return favMovies
		}
		return []
	}
	
	func addAnnotations(for theatreLocation: [Locations]) -> ([MKPointAnnotation], MKCoordinateRegion){
		var annotations: [MKPointAnnotation] = []
		var region = MKCoordinateRegion()
		for location in theatreLocation {
			if let longitudeString = location.latitude, let latitudeString = location.latitude, let longitude = Double(longitudeString), let latitude = Double(latitudeString) {
				let annotation = MKPointAnnotation()
				annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
				annotations.append(annotation)
				let centre = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
				let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
				region =  MKCoordinateRegion(center: centre, span: span)
			}
		}
		return (annotations, region)
	}
	
	func getRegion(longitude: Double, latitude: Double) -> MKCoordinateRegion {
		let centre = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
		return MKCoordinateRegion(center: centre, span: span)
	}
	
}
