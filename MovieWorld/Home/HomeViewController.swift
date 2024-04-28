//
//  HomeViewController.swift
//  Movie App
//
//  Created by Sonia Neenu on 28/04/24.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {
	
	@IBOutlet private weak var exploreButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setAccessibilityID()
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	private func setAccessibilityID() {
		exploreButton.accessibilityIdentifier = "exploreButton"
	}
	
	@IBAction func exploreAction(_ sender: Any) {
		let detailStoryboard = UIStoryboard(name: "TabbarViewController", bundle: nil)
		guard let detailVC = detailStoryboard.instantiateViewController(withIdentifier: "TabbarViewController") as? TabbarViewController else { return }
		detailVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(detailVC, animated: true)
	}
	
}
