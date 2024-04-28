//
//  MoviesAPIClient.swift
//  Movie App
//
//  Created by Sonia Neenu on 25/04/24.
//

import Foundation

struct MoviesAPIClient {
	
	static let shared = MoviesAPIClient()
	private let session = URLSession.shared
	
	func fetchData(completion: @escaping(Result<MovieListResponse, Error>) -> Void) {
		guard let path = URL(string: "https://apis.dev.ganniti.com/api/movie_listing.php") else {
			completion(.failure(APIError.invalidURL))
			return
		}
		var request = URLRequest(url: path)
		let authToken = "ABCD1234PQRS5678"
		request.setValue(authToken, forHTTPHeaderField: "Authtoken")
		let task = session.dataTask(with: request) { (data, response, error) in
			
			if let error = error {
				completion(.failure(error))
				return
			}
			
			guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
				completion(.failure(APIError.invalidResponse))
				return
			}
			
			guard let responseData = data else {
				completion(.failure(APIError.noData))
				return
			}
			do {
				let decoder = JSONDecoder()
				let movieResponse = try decoder.decode(MovieListResponse.self, from: responseData)
				DispatchQueue.main.async {
					completion(.success(movieResponse))
				}
			} catch {
				completion(.failure(error))
			}
		}
		task.resume()
	}
}

enum APIError: Error {
	case invalidURL
	case invalidResponse
	case noData
}
