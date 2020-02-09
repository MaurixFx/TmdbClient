//
//  TvShowsListPresenter.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 06-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

protocol TvShowsListPresentationLogic {
    func presentTvShows(response: TvShowsList.Fetch.Response)
    func presentError(response: TvShowsList.Error.Response)
}

class TvShowsListPresenter: TvShowsListPresentationLogic {
    weak var viewController: TvShowsListDisplayLogic?
    
    // MARK: Present Tv Shows
    func presentTvShows(response: TvShowsList.Fetch.Response) {
        let viewModel = TvShowsList.Fetch.ViewModel(listTvShows: response.listTvShows)
        viewController?.displayTvShows(viewModel: viewModel)
    }
    
    // MARK: Present Error
    func presentError(response: TvShowsList.Error.Response) {
        let errorViewModel = TvShowsList.Error.ViewModel(alertMessage: response.alertResponse.getMessage())
        viewController?.displayError(viewModel: errorViewModel)
    }
}
