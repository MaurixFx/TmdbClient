//
//  Endpoints.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 07-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation

enum Endpoints {
    
    enum Server {
        static let url = "https://api.themoviedb.org/3"
    }

    // MARK: TV SHOWS
    enum TvShows {
        static func fetchTopRatedTvShows() -> String {
            return "\(Server.url)/tv/top_rated?api_key=\(AppKeys.Codes.apiKey)&language=en-US&page=1"
        }
    }
}
