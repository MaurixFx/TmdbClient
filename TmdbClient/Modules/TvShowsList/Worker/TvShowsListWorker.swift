//
//  TvShowsListWorker.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 06-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

protocol TvShowsListWorkerLogic {
    func fetch(completionHandler: @escaping (TopRated?, AlertResponse) -> Void)
}

class TvShowsListWorker: TvShowsListWorkerLogic {
    
    func fetch(completionHandler: @escaping (TopRated?, AlertResponse) -> Void) {
        guard let urlRequest = URL(string: Endpoints.TvShows.fetchTopRatedTvShows()) else {
            completionHandler(nil, AlertResponse(status: .urlNotValid))
            return
        }
        
        ApiClient.shared.requestToApi(url: urlRequest) { (data, resp) in
            if resp.isError() {
                completionHandler(nil, resp)
            } else {
                guard let newData = data else {
                    return
                }
                
                do {
                    let jsonDecoder = JSONDecoder()
                    let items = try jsonDecoder.decode(TopRated.self, from: newData)
                    completionHandler(items, resp)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
