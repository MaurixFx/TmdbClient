//
//  TvShowsListViewController.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 06-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

protocol TvShowsListDisplayLogic: class {
    func displayTvShows(viewModel: TvShowsList.Fetch.ViewModel)
    func displayError(viewModel: TvShowsList.Error.ViewModel)
}

class TvShowsListViewController: UIViewController, TvShowsListDisplayLogic {
    
    // MARK: Create TvShowsView
    lazy var tvShowsView : TvShowsView = {
        return TvShowsView(frame: UIScreen.main.bounds)
    }()
    
    // MARK: Variables
    var interactor: TvShowsListBusinessLogic?
    var router: (NSObjectProtocol & TvShowsListRoutingLogic & TvShowsListDataPassing)?
    var listTvShows: [TvShows] = []
    var sortAsc: Bool = true

    // MARK: Object lifecycle
    init(configurator: TvShowsConfigurator = TvShowsConfigurator()) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(viewController: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        TvShowsConfigurator().configure(viewController: self)
    }
    
    // MARK: View lifecycle
    override func loadView() {
        view = tvShowsView
        tvShowsView.collectionView.delegate = self
        tvShowsView.collectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTvShows()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    // MARK: Setup Navigation
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "TV SHOWS"
        let rightButton = UIBarButtonItem(title: "Sort", style: .done, target: self, action: #selector(sortTvShows))
        rightButton.tintColor = .white
        navigationItem.rightBarButtonItem = rightButton
    }

    // MARK: Load Tv Shows
    func loadTvShows() {
        interactor?.fetchTvShows()
    }

    // MARK: Display Tv Shows
    func displayTvShows(viewModel: TvShowsList.Fetch.ViewModel) {
        listTvShows = viewModel.listTvShows
        reloadCollectionView()
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.tvShowsView.collectionView.reloadData()
        }
    }
    
    // MARK: Display Error
    func displayError(viewModel: TvShowsList.Error.ViewModel) {
        let alertViewController = UIAlertController(title: "Error", message: viewModel.alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertViewController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
    
    // MARK: Actions
    @objc func sortTvShows() {
        if listTvShows.count > 0 {
            sortAsc = !sortAsc
            let sortedList = listTvShows.sorted {
                sortAsc ? $0.name > $1.name : $0.name < $1.name
            }
            listTvShows = sortedList
            reloadCollectionView()
        }
    }
    
}

// MARK: Extension UICollectionView
extension TvShowsListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listTvShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AppKeys.Cells.tvShows,
            for: indexPath
        ) as! TvShowItemCell
        cell.displayInfo(tvShow: listTvShows[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width / 2, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
