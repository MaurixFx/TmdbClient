//
//  MainRouter.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 06-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

@objc protocol MainRoutingLogic {
    func routeToTvShowsList()
}

class MainRouter: NSObject, MainRoutingLogic {
    weak var viewController: MainViewController?
    
    func routeToTvShowsList() {
        let destinationVC = TvShowsListViewController()
        navigateToTvShowList(source: viewController, destination: destinationVC)
    }
    
    // MARK: Navigation
    func navigateToTvShowList(source: MainViewController?, destination: TvShowsListViewController) {
        let navViewController = UINavigationController(rootViewController: destination)
        navViewController.modalPresentationStyle = .fullScreen
        navViewController.navigationBar.setup(barTintColor: UIColor.orange)
        source?.show(navViewController, sender: nil)
    }
    
}
