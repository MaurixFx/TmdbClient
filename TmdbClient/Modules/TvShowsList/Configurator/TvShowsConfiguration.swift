//
//  TvShowsConfiguration.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 06-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation

class TvShowsConfigurator {
    
    func configure(viewController: TvShowsListViewController) {
        let interactor = TvShowsListInteractor()
        let presenter = TvShowsListPresenter()
        let router = TvShowsListRouter()
        let worker = TvShowsListWorker()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
}
