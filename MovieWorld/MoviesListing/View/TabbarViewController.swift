//
//  TabbarViewController.swift
//  Movie App
//
//  Created by Sonia Neenu on 23/04/24.
//

import Foundation
import UIKit

final class TabbarViewController: UITabBarController {
	
	var moviesListNavigationControllers: MovieListViewController!
	var favouriteMoviesViewControllers: FavouriteMoviesViewController!
	
	var viewModel = TabbarViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViewControllers()
		setupTabbarItem()
	}
	
	func setupViewControllers() {
		let moviesStoryboard = UIStoryboard(name: "MovieListViewController", bundle: nil)
		guard let moviesViewController = moviesStoryboard.instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController else { fatalError("Unable to instantiate viewcontroller from storyboard")
		}
		moviesListNavigationControllers = moviesViewController
		let moviesListNavigationController = UINavigationController(rootViewController: moviesListNavigationControllers)
		
		

		let favouriteMoviesStoryboard = UIStoryboard(name: "FavouriteMoviesViewController", bundle: nil)
		guard let favouriteMoviesViewController = favouriteMoviesStoryboard.instantiateInitialViewController() as? FavouriteMoviesViewController else {
			fatalError("unable to instantiate viewcontroller from storyboard")
		}
		favouriteMoviesViewControllers = favouriteMoviesViewController
		let favouriteListNavigationController = UINavigationController(rootViewController: favouriteMoviesViewControllers)
		self.viewControllers = [moviesListNavigationController, favouriteListNavigationController]
		
	}
	
	func setupTabbarItem() {
		for item in viewModel.tabbarItems {
			let tabbarItem = UITabBarItem(title: item.title, image: UIImage(named: item.image), selectedImage: UIImage(named: item.selectedImage))
			switch item.title {
				case "Home":
					moviesListNavigationControllers.tabBarItem = tabbarItem
				case "My Favourites":
					favouriteMoviesViewControllers.tabBarItem = tabbarItem
				default:
					break
			}
			
		}
	}
	
}
