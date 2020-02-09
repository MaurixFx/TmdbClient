//
//  TvShowsListInteractorTests.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 08-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

@testable import TmdbClient
import XCTest

class TvShowsListInteractorTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: TvShowsListInteractor?
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupTvShowsListInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupTvShowsListInteractor() {
        sut = TvShowsListInteractor()
    }
    
    // MARK: Test doubles
    class TvShowsListPresentationLogicSpy: TvShowsListPresentationLogic {
        
        // MARK: Method call expectations
        var presentTvShowsIsCalled = false
        var presentErrorIsCalled = false
        
        // MARK: Spied methods
        func presentTvShows(response: TvShowsList.Fetch.Response) {
            presentTvShowsIsCalled = true
        }
        
        func presentError(response: TvShowsList.Error.Response) {
            presentErrorIsCalled = true
        }
    }
    
    class TvShowsListWorkerLogicSpy: TvShowsListWorkerLogic {
        
        // MARK: Method call expectations
        var fetchTvShowsCalled = false
        
        // MARK: Spied methods
        func fetch(completionHandler: @escaping (TopRated?, AlertResponse) -> Void) {
            fetchTvShowsCalled = true
            completionHandler(Seed.getTopRatedTvShows(), AlertResponse(status: .successFetch))
        }
    }
    
    // MARK: Tests
    func testFetchTvShowsShouldAskWorkerToFetchTvShows() {
        // Given
        let tvShowsListWorkerLogicSpy = TvShowsListWorkerLogicSpy()
        sut?.worker = tvShowsListWorkerLogicSpy
        
        // When
        sut?.fetchTvShows()

        // Then
        XCTAssertTrue(tvShowsListWorkerLogicSpy.fetchTvShowsCalled, "should ask worker to fetch tv shows")
    }
    
    func testFetchTvShowsShouldAskPresenterToPresentInfo() {
        // Given
        let tvShowsPresentationLogicSpy = TvShowsListPresentationLogicSpy()
        sut?.presenter = tvShowsPresentationLogicSpy
    
        // When
        sut?.fetchTvShows()

        // Then
        DispatchQueue.global().asyncAfter(deadline: .now() + 6) {
            XCTAssert(tvShowsPresentationLogicSpy.presentTvShowsIsCalled, "fetchTvShows() should ask presenter to present info")
        }
    }

    func testFetchTvShowsShouldAskPresenterToPresentErrorIfExistError()  {
        // Given
        let tvShowsPresentationLogicSpy = TvShowsListPresentationLogicSpy()
        sut?.presenter = tvShowsPresentationLogicSpy
        
        // When
        sut?.worker?.fetch(completionHandler: { (top, resp) in
            let errResp = TvShowsList.Error.Response(alertResponse: AlertResponse(status: .serverFail))
            self.sut?.presenter?.presentError(response: errResp)
        })
        
        // Then
        DispatchQueue.global().asyncAfter(deadline: .now() + 6) {
            XCTAssert(tvShowsPresentationLogicSpy.presentErrorIsCalled, "should ask presenter to display Error")
        }
    }
}
