//
//  TabbarViewModel.swift
//  Movie App
//
//  Created by Sonia Neenu on 24/04/24.
//

import Foundation

struct TabbarItemContent {
	var image: String
	var selectedImage: String
	var title: String
	
	init(image: String, selectedImage: String, title: String) {
		self.image = image
		self.selectedImage = selectedImage
		self.title = title
	}
}

final class TabbarViewModel {
	
	var tabbarItems = [TabbarItemContent]()
	var imageNames = ["home", "favfolder"]
	var selectedImageNames = ["homeSelected", "favfolderSelected"]
	var titles: [String] = ["Home", "My Favourites"]
	
	init() {
		for index in 0..<titles.count {
			tabbarItems.append(TabbarItemContent.init(image: imageNames[index], selectedImage: selectedImageNames[index], title: titles[index]))
		}
	}
	
}
