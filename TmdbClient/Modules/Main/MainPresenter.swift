//
//  MainPresenter.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 06-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

protocol MainPresentationLogic {
    func presentSomething(response: Main.Something.Response)
}

class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Main.Something.Response) {
        let viewModel = Main.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
