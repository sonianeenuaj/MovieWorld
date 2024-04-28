//
//  ImageHandler.swift
//  Movie App
//
//  Created by Sonia Neenu on 28/04/24.
//

import Foundation
import UIKit

final class ImageHandler {
	
	static func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
		let task = URLSession.shared.dataTask(with: url) { data, _, error in
			
			guard let data = data, let image = UIImage(data: data), error == nil else {
				print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
				completion(nil)
				return
			}
			DispatchQueue.main.async {
				completion(image)
			}
			
		}
		task.resume()
	}
	
}
