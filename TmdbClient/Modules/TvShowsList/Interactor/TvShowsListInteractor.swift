//
//  TvShowsListInteractor.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 06-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

protocol TvShowsListBusinessLogic {
    func fetchTvShows()
}

protocol TvShowsListDataStore { }

class TvShowsListInteractor: TvShowsListBusinessLogic, TvShowsListDataStore {
    var presenter: TvShowsListPresentationLogic?
    var worker: TvShowsListWorkerLogic?

    // MARK: Fetch Tv Shows
    func fetchTvShows() {
        worker?.fetch { (top, resp) in
            if resp.isError() {
                let respError = TvShowsList.Error.Response(alertResponse: resp)
                self.presenter?.presentError(response: respError)
            } else {
                guard let topShows = top else { return }
                let resp = TvShowsList.Fetch.Response(listTvShows: topShows.results)
                self.presenter?.presentTvShows(response: resp)
            }
        }
    }
}
