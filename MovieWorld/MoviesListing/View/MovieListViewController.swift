//
//  MovieListViewController.swift
//  Movie App
//
//  Created by Sonia Neenu on 23/04/24.
//

import Foundation
import UIKit

final class MovieListViewController: UIViewController {
	
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var searchBar: UISearchBar!
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var filterColectionView: UICollectionView!
	@IBOutlet private weak var emptyView: UIView!
	
	var viewModel = MoviesListViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.getDataFromServer()
		setAccesibilityID()
		setupText()
		setupTableView()
		setupCollectionView()
		viewModel.delegate = self
		searchBar.delegate = self
		emptyView.isHidden = true
	}
	
	private func setAccesibilityID() {
		tableView.accessibilityIdentifier = "MoviesListTableView"
	}
	
	private func setupText() {
		searchBar.placeholder = "Search for movies"
	}
	
	private func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "MoviesTableViewCell")
		setAccesibilityID()
	}
	
	private func setupCollectionView() {
		filterColectionView.delegate = self
		filterColectionView.dataSource = self
		filterColectionView.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCollectionViewCell")
	}
	
	private func setEmptyView() {
		if viewModel.getCount() == 0 {
			emptyView.isHidden = false
			tableView.isHidden = true
		} else {
			emptyView.isHidden = true
			tableView.isHidden = false
		}
	}
	
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as? MoviesTableViewCell else { return UITableViewCell() }
		DispatchQueue.main.async {
			let cellViewModel = self.viewModel.getCellViewModel(index: indexPath.row)
				cell.selectionStyle = .none
				cell.configureCell(viewModel: cellViewModel)
		}
		return cell
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.getCount()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let detailViewModel = viewModel.getDetailCellViewModel(index: indexPath.row) else { return }
		let detailStoryboard = UIStoryboard(name: "MoviesDetailViewController", bundle: nil)
		guard let detailVC = detailStoryboard.instantiateViewController(withIdentifier: "MoviesDetailViewController") as? MoviesDetailViewController else { return }
		detailVC.hidesBottomBarWhenPushed = true
		detailVC.setDetails(viewModel: detailViewModel)
		self.navigationController?.pushViewController(detailVC, animated: true)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.getFilterArrayCount()
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell()}
		cell.setText(value: viewModel.filterNameArray?[indexPath.row] ?? "")
		cell.setSelection(isSelected: indexPath.item == viewModel.selectedFilterIndex)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let spacing: CGFloat = 30
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as? FilterCollectionViewCell else { return .zero}
		let text = (viewModel.filterNameArray?[indexPath.item] ?? "")
		let contentWidth = text.size(withAttributes: [.font: cell.filterLabel.font ?? ""]).width
		let cellWidth = contentWidth + spacing
		return CGSize(width: cellWidth, height: 32)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let cell = collectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell else { return }
		cell.delegate = self
		cell.setData(category: viewModel.filterNameArray?[indexPath.item] ?? "")
		viewModel.setSelectedFilterIndex(index: indexPath.item)
	}
	
}

extension MovieListViewController: MoviesListViewModelDelegate, FilterCollectionViewCellDlegate {
	
	func filterData(category: String) {
		viewModel.filterByCategory(category: category)
	}
	
	func reloadData() {
		tableView.reloadData()
		filterColectionView.reloadData()
		setEmptyView()
	}
	
}

extension MovieListViewController: UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		viewModel.searchData(with: searchText)
	}
	
}
