//
//  MovieDataModel.swift
//  Movie App
//
//  Created by Sonia Neenu on 25/04/24.
//

import Foundation

struct MovieListResponse: Codable {
	let success: Bool?
	let message: String?
	let data: [MovieCategory]?
}

struct MovieCategory: Codable {
	let movieCategory: String?
	let movieCategoryCode: String?
	let movieList: [MovieList]?
	
	enum CodingKeys: String, CodingKey {
		case movieCategory = "movie_category"
		case movieCategoryCode = "movie_category_code"
		case movieList = "movie_list"
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		movieCategory = try values.decodeIfPresent(String.self, forKey: .movieCategory)
		movieCategoryCode = try values.decodeIfPresent(String.self, forKey: .movieCategoryCode)
		movieList = try values.decodeIfPresent([MovieList].self, forKey: .movieList)
	}
}

struct MovieList: Codable {
	let name: String?
	let description: String?
	let releaseYear: String?
	let movieBanner: String?
	let movieIcon: String?
	let ratings: String?
	let theatreLocation: [Locations]?
	
	enum CodingKeys: String, CodingKey {
		case name = "name"
		case description = "description"
		case releaseYear = "release_year"
		case movieBanner = "movie_banner"
		case movieIcon = "movie_icon"
		case ratings = "ratings"
		case theatreLocation = "theatre_locations"
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		releaseYear = try values.decodeIfPresent(String.self, forKey: .releaseYear)
		movieBanner = try values.decodeIfPresent(String.self, forKey: .movieBanner)
		movieIcon = try values.decodeIfPresent(String.self, forKey: .movieIcon)
		ratings = try values.decodeIfPresent(String.self, forKey: .ratings)
		theatreLocation = try values.decodeIfPresent([Locations].self, forKey: .theatreLocation)
	}
}

struct Locations: Codable {
	let longitude: String?
	let latitude: String?
}
 
