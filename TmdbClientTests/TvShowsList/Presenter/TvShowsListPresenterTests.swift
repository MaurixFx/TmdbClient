//
//  TvShowsListPresenterTests.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 08-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

@testable import TmdbClient
import XCTest

class TvShowsListPresenterTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: TvShowsListPresenter?
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupTvShowsListPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupTvShowsListPresenter() {
        sut = TvShowsListPresenter()
    }
    
    // MARK: Test doubles
    class TvShowsListDisplayLogicSpy: TvShowsListDisplayLogic {
        
        // MARK: Method call expectations
        var displayTvShowsCalled = false
        var displayErrorCalled = false
        
        // MARK: Spied methods
        func displayTvShows(viewModel: TvShowsList.Fetch.ViewModel) {
            displayTvShowsCalled = true
        }
        
        func displayError(viewModel: TvShowsList.Error.ViewModel) {
            displayErrorCalled = true
        }
    }
    
    // MARK: Tests
    func testPresentFetchedTvShowsShouldAskViewControllerToDisplayFetchedTvShows() {
        // Given
        let spy = TvShowsListDisplayLogicSpy()
        sut?.viewController = spy
        let response = TvShowsList.Fetch.Response(listTvShows: Seed.getTvShowsList())
        
        // When
        sut?.presentTvShows(response: response)
        
        // Then
        XCTAssertTrue(spy.displayTvShowsCalled, "Presenting fetched tv shows should ask view controller to display them")
    }
    
    func testErrorFetchedTvShowsShouldAskViewControllerToDisplayErrorTvShows() {
        // Given
        let spy = TvShowsListDisplayLogicSpy()
        sut?.viewController = spy
        let response = TvShowsList.Error.Response(alertResponse: AlertResponse(status: .serverFail))
        
        // When
        sut?.presentError(response: response)
        
        // Then
        XCTAssertTrue(spy.displayErrorCalled, "Presenting Error fetched tv shows should ask view controller to display")
    }
}
