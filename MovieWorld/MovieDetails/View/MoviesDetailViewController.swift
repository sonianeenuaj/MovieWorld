//
//  MoviesDetailViewController.swift
//  Movie App
//
//  Created by Sonia Neenu on 26/04/24.
//

import Foundation
import UIKit
import MapKit

final class MoviesDetailViewController: UIViewController {
	
	@IBOutlet private weak var scrollView: UIScrollView!
	@IBOutlet private weak var mainView: UIView!
	@IBOutlet private weak var filmImageIcon: UIImageView!
	@IBOutlet private weak var addToFavButton: UIButton!
	@IBOutlet private weak var descriptionLabel: UILabel!
	@IBOutlet private weak var locationLabel: UILabel!
	@IBOutlet private weak var mapView: MKMapView!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var addOrRemoveLabel: UILabel!
	
	var viewModel: MoviesDetailsViewModel?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setData()
		updateAddtoFavImage()
		setupUI()
		setAccesibilityID()
	}
	
	private func setAccesibilityID() {
		view.accessibilityIdentifier = "MoviesDetailView"
		addToFavButton.accessibilityIdentifier = "addToFavButton"
		addOrRemoveLabel.accessibilityIdentifier = "addOrRemoveLabel"
	}
	
	func setData() {
		guard let viewModel = viewModel else {
			return
		}
		viewModel.delegate = self
		viewModel.setData()
	}
	
	func setDetails(viewModel: MoviesDetailsViewModel?) {
		self.viewModel = viewModel
		setData()
	}
	
	private func setupUI() {
		filmImageIcon.layer.cornerRadius = 4
	}
	
	@IBAction func addToFavAction(_ sender: Any) {
		viewModel?.setAddTofav()
		updateAddtoFavImage()
	}
	
	func updateAddtoFavImage() {
		let image = viewModel?.isAddedToFavourite() ?? false ? "addedToFavIcon" : "favourite"
		let selectedImage = UIImage(named: image)
		addToFavButton?.setImage(selectedImage, for: .normal)
		addOrRemoveLabel.text = viewModel?.isAddedToFavourite() ?? false ? "Remove From Favourite" : "Add To Favourite"
	}
	
}

extension MoviesDetailViewController: MoviesDetailsViewModelDelegate {
	
	func setDetails(data: MovieList) {
		guard let urlString = data.movieBanner, let url = URL(string: urlString) else {
			return
		}
		ImageHandler.loadImage(from: url) { [weak self] image in
			guard let self = self else { return }
			self.filmImageIcon.image = image
		}
	
		descriptionLabel?.text = data.description
		titleLabel?.text = data.name
		guard let theatreLocation = data.theatreLocation else { return }
		for locations in theatreLocation {
			let annotation = MKPointAnnotation()
			guard let longitude = Double(locations.longitude ?? ""), let latitude = Double(locations.latitude ?? "") else { return }
			annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
			
			mapView?.addAnnotation(annotation)
			
			let centre = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
			let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
			let region = MKCoordinateRegion(center: centre, span: span)
			mapView?.setRegion(region, animated: true)
		}
	}
	
}
