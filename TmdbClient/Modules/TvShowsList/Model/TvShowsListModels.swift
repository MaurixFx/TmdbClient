//
//  TvShowsListModels.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 06-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

enum TvShowsList {
    
    // MARK: Fetch
    enum Fetch {
        struct Request {
        }
        struct Response {
            var listTvShows: [TvShows]
        }
        struct ViewModel {
            var listTvShows: [TvShows]
        }
    }
    
    // MARK: Error
    enum Error {
        struct Response {
            var alertResponse: AlertResponse
        }
        struct ViewModel {
            var alertMessage: String
        }
    }
}

struct TopRated: Codable {
    var results: [TvShows]
}

struct TvShows: Codable {
    var name: String
    var posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case posterPath = "poster_path"
    }
}

