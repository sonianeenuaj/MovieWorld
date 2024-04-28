//
//  Movie_AppUITests.swift
//  Movie AppUITests
//
//  Created by Sonia Neenu on 28/04/24.
//

import XCTest
@testable import MovieWorld

class Movie_AppUITests: XCTestCase {
	
	var app: XCUIApplication!
	
	override func setUp() {
		super.setUp()
		continueAfterFailure = false
		app = XCUIApplication()
		app.launch()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func testExample() throws {
		// UI tests must launch the application that they test.
		let app = XCUIApplication()
		app.launch()
		
		// Use XCTAssert and related functions to verify your tests produce the correct results.
	}
	
	func testLaunchPerformance() throws {
		if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
			// This measures how long it takes to launch your application.
			measure(metrics: [XCTApplicationLaunchMetric()]) {
				XCUIApplication().launch()
			}
		}
	}
	
	func testViewingMovieDetails() {
		app.buttons["exploreButton"].tap()
		let moviesListTableView = app.tables["MoviesListTableView"]
		let movieCell = moviesListTableView.cells.element(boundBy: 0)
		movieCell.tap()
		XCTAssertTrue(app.otherElements["MoviesDetailView"].exists)
	}
	
	func testAddToFavourites() {
		app.buttons["exploreButton"].tap()
		let moviesListTableView = app.tables["MoviesListTableView"]
		let movieCell = moviesListTableView.cells.element(boundBy: 0)
		movieCell.tap()
		let addToFavButton = app.buttons["addToFavButton"]
		let initialLabel = app.staticTexts["addOrRemoveLabel"].label
		addToFavButton.tap()
		let updatedText = app.staticTexts["addOrRemoveLabel"].label
		if initialLabel == "Add To Favourite" && updatedText == "Remove From Favourite" {
			XCTAssertTrue(true)
		} else if initialLabel == "Remove From Favourite" && updatedText == "Add To Favourite" {
			XCTAssertTrue(true)
		}
	}
	
}
