//
//  TvShowsListRouter.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 06-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

@objc protocol TvShowsListRoutingLogic {
}

protocol TvShowsListDataPassing {
    var dataStore: TvShowsListDataStore? { get }
}

class TvShowsListRouter: NSObject, TvShowsListRoutingLogic, TvShowsListDataPassing {
    weak var viewController: TvShowsListViewController?
    var dataStore: TvShowsListDataStore?

}
