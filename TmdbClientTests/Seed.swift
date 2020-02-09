//
//  Seed.swift
//  TmdbClientTests
//
//  Created by Mauricio Figueroa olivares on 08-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation
@testable import TmdbClient

class Seed {
    
    static func getTvShowsList() -> [TvShows] {
        var listShows: [TvShows] = []
        var show = TvShows(name: "Chernobyl", posterPath: "/hlLXt2tOPT6RRnjiUmoxyG1LTFi.jpg")
        listShows.append(show)
        show = TvShows(name: "", posterPath: "hlLXt2tOPT6RRnjiUmoxyG1LTFi.jpg")
        listShows.append(show)
        return listShows
    }
    
    static func getTopRatedTvShows() -> TopRated {
        let top = TopRated(results: getTvShowsList())
        return top
    }
    
    static func getWrongUrlFetchTvShows() -> URL? {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/top_rated?api_key=23232325140f6b43c&language=en-US&page=1") else {
            return nil
        }
        return url
    }
    
    static func getDataTvShowsFromJson() -> Data? {
        var data: Data?
        let bundle = Bundle(for: Seed.self)
        if let path = bundle.path(forResource: "top_rated", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            
            do {
                data = try Data(contentsOf: url, options: Data.ReadingOptions.mappedIfSafe)
            } catch {
                return nil
            }
        }
        return data
    }
    
    static func getDataTvShowsFromWrongJson() -> Data? {
        var data: Data?
        let bundle = Bundle(for: Seed.self)
        if let path = bundle.path(forResource: "top_rated_wrong", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            
            do {
                data = try Data(contentsOf: url, options: Data.ReadingOptions.mappedIfSafe)
            } catch {
                return nil
            }
        }
        return data
    }
}
