//
//  TvShowsTest.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 09-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

@testable import TmdbClient
import XCTest

class TvShowsModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetTopRatedValidJsonData() {
        // Given
        var topRated: TopRated?
        guard let data = Seed.getDataTvShowsFromJson() else {
            return XCTFail("JSON doesn't exist")
        }
        
        // When
        do {
            let jsonDecoder = JSONDecoder()
            topRated = try jsonDecoder.decode(TopRated.self, from: data)
        } catch let error {
            print(error.localizedDescription)
        }
        
        // Then
        XCTAssertNotNil(topRated, "TopRated shouldn't be nil")
    }
    
    func testGetTopRatedNotValidJsonData() {
        // Given
        var topRated: TopRated?
        guard let data = Seed.getDataTvShowsFromWrongJson() else {
            return XCTFail("JSON doesn't exist")
        }
        
        // When
        do {
            let jsonDecoder = JSONDecoder()
            topRated = try jsonDecoder.decode(TopRated.self, from: data)
        } catch let error {
            print(error.localizedDescription)
        }
        
        // Then
        XCTAssertNil(topRated, "TopRated should be nil because the field name is incorrect")
    }
    
    func testAsignationtheNameFieldTvShowFromJson() {
        // Given
        var topRated: TopRated?
        guard let data = Seed.getDataTvShowsFromJson() else {
            return XCTFail("JSON doesn't exist")
        }
        
        // When
        do {
            let jsonDecoder = JSONDecoder()
            topRated = try jsonDecoder.decode(TopRated.self, from: data)
        } catch let error {
            print(error.localizedDescription)
        }
        
        // Then
        XCTAssertEqual(topRated?.results[0].name, "Chernobyl")
    }
    
    func testAsignationthePosterPathFieldTvShowFromJson() {
        // Given
        var topRated: TopRated?
        guard let data = Seed.getDataTvShowsFromJson() else {
            return XCTFail("JSON doesn't exist")
        }
        
        // When
        do {
            let jsonDecoder = JSONDecoder()
            topRated = try jsonDecoder.decode(TopRated.self, from: data)
        } catch let error {
            print(error.localizedDescription)
        }
        
        // Then
        XCTAssertEqual(topRated?.results[0].posterPath, "/hlLXt2tOPT6RRnjiUmoxyG1LTFi.jpg")
    }
    
    func testPosterPathDoesntHaveSlashInTheBeginning() {
        
        // Given
        var topRated: TopRated?
        guard let data = Seed.getDataTvShowsFromWrongJson() else {
            return XCTFail("JSON doesn't exist")
        }
        
        // When
        do {
            let jsonDecoder = JSONDecoder()
            topRated = try jsonDecoder.decode(TopRated.self, from: data)
        } catch let error {
            print(error.localizedDescription)
        }
        
        guard let list = topRated?.results else { return }
        let character = String(list[0].posterPath.prefix(1))
        
        // Then
        XCTAssertNotEqual(character, "/", "the first character in the field posterPath is not equal to / ")
        
    }
}
