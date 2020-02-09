//
//  MainViewController.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 06-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: Create MainView
    lazy var mainView : MainView = {
        return MainView(frame: UIScreen.main.bounds)
    }()
    
    // MARK: Variables
    var router: (NSObjectProtocol & MainRoutingLogic)?

    // MARK: Object lifecycle
    init(configurator: MainConfigurator = MainConfigurator()) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(viewController: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        MainConfigurator().configure(viewController: self)
    }

    // MARK: View lifecycle
    override func loadView() {
        view = mainView
        mainView.goButton.addTarget(self, action: #selector(displayTvShowsList), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Actions
    @objc func displayTvShowsList() {
        router?.routeToTvShowsList()
    }

}
