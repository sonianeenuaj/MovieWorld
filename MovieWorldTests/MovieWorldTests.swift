//
//  Movie_AppTests.swift
//  Movie AppTests
//
//  Created by Sonia Neenu on 28/04/24.
//

import XCTest
@testable import MovieWorld

class Movie_AppTests: XCTestCase {
	
	var sut: MoviesAPIClient!
	
	override func setUp() {
		super.setUp()
		sut = MoviesAPIClient.shared
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
	
	
	func test_fetch_data_success() {
		//Given
		let expectation = self.expectation(description: "Fetching movie data")
		
		//When
		sut.fetchData { result in
			switch result {
				case .success(let response):
					//Then
					XCTAssertNotNil(response)
					expectation.fulfill()
				case .failure(let error):
					XCTFail("fetching movies data failed with erroe: \(error.localizedDescription)")
			}
		}
		
		waitForExpectations(timeout: 5)
	}
	
	func test_fetch_data_failure() {
		//Given
		let expectation = self.expectation(description: "Fetching movie data")
		
		//When
		sut.fetchData { result in
			switch result{
				case .success:
					XCTFail("Fetching Movie Data should fail")
				case .failure(let error):
					//Then
					XCTAssertNotNil(error)
					expectation.fulfill()
			}
		}
		waitForExpectations(timeout: 5)
	}
	
}
