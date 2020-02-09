//
//  TvShowsListWorkerTests.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 08-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

@testable import TmdbClient
import XCTest

class TvShowsListWorkerTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: TvShowsListWorker?
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupTvShowsListWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupTvShowsListWorker() {
        sut = TvShowsListWorker()
    }
    
    // MARK: Test doubles
    
    // MARK: Tests
    func testErrorFetchTvShowsFromApiClient() {
        // Given
        let exp = expectation(description: "Error fetch tv shows from api client")
        guard let url = Seed.getWrongUrlFetchTvShows() else { return }
        var respError: AlertResponse!

        // When
        ApiClient.shared.requestToApi(url: url) { (data, resp) in
            respError = resp
            exp.fulfill()
        }

        // Then
        waitForExpectations(timeout: 2) { (_) in
            XCTAssertTrue(respError.isError())
        }
    }
    
    func testFetchTvShowsSuccessFromApiClient() {
        // Given
        let exp = expectation(description: "Success fetch tv shows from api client")
        guard let urlRequest = URL(string: Endpoints.TvShows.fetchTopRatedTvShows()) else {
            return
        }
        
        var respError: AlertResponse!
        
        // When
        ApiClient.shared.requestToApi(url: urlRequest) { (data, resp) in
            respError = resp
            exp.fulfill()
        }

        // Then
        waitForExpectations(timeout: 2) { (_) in
            XCTAssertTrue(!respError.isError())
        }
    }
    
    func testFetchTvShowsShouldReturnData() {
        // Given
        let exp = expectation(description: "fetch tv shows should be return data")
        guard let urlRequest = URL(string: Endpoints.TvShows.fetchTopRatedTvShows()) else {
            return
        }
        
        var newData: Data?
        
        // When
        ApiClient.shared.requestToApi(url: urlRequest) { (data, resp) in
            newData = data
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 2) { (_) in
            XCTAssertNotNil(newData, "the data shouldn't be null")
        }
    }
    
    func testFetchTvShowsShouldNotReturnData() {
        // Given
        let exp = expectation(description: "fetch tv shows shouldn't return data")
        guard let urlRequest = Seed.getWrongUrlFetchTvShows() else { return }
        
        var newData: Data?
        
        // When
        ApiClient.shared.requestToApi(url: urlRequest) { (data, resp) in
            newData = data
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 2) { (_) in
            XCTAssertNil(newData, "the data should be nil")
        }
    }
    
    func testFetchTvShowsPosterPathShouldHaveToSlashInTheBeginning() {
        // Given
        let exp = expectation(description: "fetch tv shows and validate the posterPath")
        guard let urlRequest = URL(string: Endpoints.TvShows.fetchTopRatedTvShows()) else {
            return
        }
        
        var newData: Data?
        var topRated: TopRated?
        
        // When
        ApiClient.shared.requestToApi(url: urlRequest) { (data, resp) in
            newData = data
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 2) { (_) in
            
            guard let data = newData else {
                XCTFail("the data shouldn't be nil")
                return
            }
            
            // When
            do {
                let jsonDecoder = JSONDecoder()
                topRated = try jsonDecoder.decode(TopRated.self, from: data)
            } catch let error {
                print(error.localizedDescription)
                XCTFail("the data should be in correct format")
            }
            
            guard let listShows = topRated?.results else {
                return
            }
        
            for show in listShows {
                let character = String(show.posterPath.prefix(1))
                XCTAssertEqual(character, "/", "the first character in the field posterPath should always be / ")
            }
        }
    
    }
}
