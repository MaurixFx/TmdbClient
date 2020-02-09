//
//  MainConfigurator.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 06-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation

class MainConfigurator {
    
    func configure(viewController: MainViewController) {
        let router = MainRouter()
        viewController.router = router
        router.viewController = viewController
    }
}
