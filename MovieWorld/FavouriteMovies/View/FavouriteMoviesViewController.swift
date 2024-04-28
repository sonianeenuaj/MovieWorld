//
//  FavouriteMoviesViewController.swift
//  Movie App
//
//  Created by Sonia Neenu on 23/04/24.
//

import Foundation
import UIKit

final class FavouriteMoviesViewController: UIViewController {
	
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var emptyView: UIView!
	
	var viewModel = FavouriteMoviesViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		setEmptyView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		viewModel.favouriteMovies = viewModel.loadFavMovies()
		viewModel.delegate = self
	}
	
	private func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "MoviesTableViewCell")
	}
	
	private func setEmptyView() {
		if viewModel.getRowCount() == 0 {
			emptyView.isHidden = false
			tableView.isHidden = true
		} else {
			emptyView.isHidden = true
			tableView.isHidden = false
		}
	}
	
}

extension FavouriteMoviesViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.getRowCount()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as? MoviesTableViewCell else { return UITableViewCell() }
		let cellViewModel = viewModel.getCellViewModel(index: indexPath.row)
		cell.selectionStyle = .none
		cell.configureCell(viewModel: cellViewModel)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let detailViewModel = viewModel.getDetailCellViewModel(index: indexPath.row) else { return }
		let detailStoryboard = UIStoryboard(name: "MoviesDetailViewController", bundle: nil)
		guard let detailVC = detailStoryboard.instantiateViewController(withIdentifier: "MoviesDetailViewController") as? MoviesDetailViewController else { return }
		detailVC.hidesBottomBarWhenPushed = true
		detailVC.setDetails(viewModel: detailViewModel)
		self.navigationController?.pushViewController(detailVC, animated: true)
	}
	
}

extension FavouriteMoviesViewController: FavouriteMoviesViewModelDelegate {
	
	func didupdateFavMovies(data: [MovieList]) {
		viewModel.favouriteMovies = data
		tableView.reloadData()
		setEmptyView()
	}
	
}
