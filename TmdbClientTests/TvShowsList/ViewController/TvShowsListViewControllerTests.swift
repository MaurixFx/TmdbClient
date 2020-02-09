//
//  TvShowsListViewControllerTests.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 08-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

@testable import TmdbClient
import XCTest

class TvShowsListViewControllerTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: TvShowsListViewController?
    var window: UIWindow?
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupTvShowsListViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupTvShowsListViewController() {
        sut = TvShowsListViewController()
    }
    
    func loadView() {
        guard let window = window, let sut = sut else {
            return
        }
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    class TvShowsListBusinessLogicSpy: TvShowsListBusinessLogic {
        
        // MARK: Method call expectations
        var fetchTvShowsCalled = false
        
        // MARK: Spied methods
        func fetchTvShows() {
            fetchTvShowsCalled = true
        }
    }
    
    class CollectionViewSpy: UICollectionView {
        
        // MARK: Method call expectations
        var reloadDataCalled = false
        
        // MARK: Spied methods
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    // MARK: Tests
    func testInitShouldSetViewControllerRouter() {

        // Then
        XCTAssertNotNil(sut?.router)
    }
    
    func testInitShouldSetViewControllerOutput() {

        // Then
        XCTAssertNotNil(sut?.interactor)
    }
  
    func testInitShouldSetPresenterOutput() {

        // Then
        if let interactor = sut?.interactor as? TvShowsListInteractor,
            let presenter = interactor.presenter as? TvShowsListPresenter {
            
            XCTAssertNotNil(presenter.viewController)
            
        } else {
            XCTFail()
        }
    }
    
    func testInitShouldSetInteractorOutput() {

        // Then
        if let interactor = sut?.interactor as? TvShowsListInteractor {
            XCTAssertNotNil(interactor.presenter)
        } else {
            XCTFail()
        }
    }
    
    func testInitShouldSetWorkerInput() {

        // Then
        if let interactor = sut?.interactor as? TvShowsListInteractor {
            XCTAssertNotNil(interactor.worker)
        } else {
            XCTFail()
        }
    }
    
    func testNavigationControllerShouldHaveTitle() {

        // When
        loadView()

        // Then
        XCTAssertEqual(sut?.navigationItem.title, "TV SHOWS", "The title in navigation controller should be TV SHOWS")
    }
    
    func testNavigationControllerShouldHaveRighButton() {

        // When
        loadView()

        // Then
        XCTAssertNotNil(sut?.navigationItem.rightBarButtonItem, "The navigation controller should have a right button")
    }
    
    func testShouldFetchTvShowsWhenViewIsLoaded() {
        // Given
        let spy = TvShowsListBusinessLogicSpy()
        sut?.interactor = spy
        
        // When
        loadView()
        print(spy.fetchTvShowsCalled)
        
        // Then
        XCTAssertTrue(spy.fetchTvShowsCalled, "Should fetch tv shows when the view is loaded")
    }
    
    func testShouldDisplayFetchedTvShows() {
        // Given
        let collectionViewSpy = CollectionViewSpy(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        sut?.tvShowsView.collectionView = collectionViewSpy

        // When
        let viewModel = TvShowsList.Fetch.ViewModel(listTvShows: Seed.getTvShowsList())
        sut?.displayTvShows(viewModel: viewModel)

        // Then
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            XCTAssert(collectionViewSpy.reloadDataCalled, "Displaying fetched tv shows should reload the collection view")
        }
    }
    
    func testShouldSetupCollectionViewDataSource() {
        // Given
        let collectionViewSpy = CollectionViewSpy(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        sut?.tvShowsView.collectionView = collectionViewSpy
        
        // When
        loadView()
        
        // Then
        XCTAssertNotNil(collectionViewSpy.dataSource)
    }

    func testShouldSetupCollectionViewDelegate() {
        // Given
        let collectionViewSpy = CollectionViewSpy(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        sut?.tvShowsView.collectionView = collectionViewSpy
        
        // When
        loadView()
        
        // Then
        XCTAssertNotNil(collectionViewSpy.delegate)
    }

    func testFetchedTvShowsWithEmptyData() {
        // Given
        let viewModel = TvShowsList.Fetch.ViewModel(listTvShows: [])

        // When
        sut?.displayTvShows(viewModel: viewModel)

        // Then
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            DispatchQueue.main.async {
                let numberOfItems = self.sut?.tvShowsView.collectionView.numberOfItems(inSection: 0)
                XCTAssertEqual(numberOfItems, 0, "The number of items is 0")
            }
        }
    }
    
    func testNumberOfSectionsInCollectionViewShouldAlwaysBeOne() {
        // Given
        let list = Seed.getTvShowsList()
        let viewModel = TvShowsList.Fetch.ViewModel(listTvShows: list)
        
        // When
        sut?.displayTvShows(viewModel: viewModel)

        // Then
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                let numberOfSections = self.sut?.tvShowsView.collectionView.numberOfSections
                XCTAssertEqual(numberOfSections, 1, "The number of sections of collection view should be always be one")
            }
        }
    }

    func testNumberOfRowsInAnySectionShouldEqualNumberOfTvShowsToDisplay() {
        // Given
        let list = Seed.getTvShowsList()
        let viewModel = TvShowsList.Fetch.ViewModel(listTvShows: list)

        // When
        sut?.displayTvShows(viewModel: viewModel)

        // Then
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            DispatchQueue.main.async {
                let numberOfItems = self.sut?.tvShowsView.collectionView.numberOfItems(inSection: 0)
                XCTAssertEqual(numberOfItems, list.count, "The number of items in CollectionView should equal the number of tv shows to display")
            }
        }
    }

    func testShouldConfigureCollectionViewCellToDisplayTvShow() {
        // Given
        let list = Seed.getTvShowsList()
        let viewModel = TvShowsList.Fetch.ViewModel(listTvShows: list)

        // When
        sut?.displayTvShows(viewModel: viewModel)

        // Then
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: 0, section: 0)
                guard let cell = self.sut?.tvShowsView.collectionView.cellForItem(at: indexPath) as? TvShowItemCell else { return }
                guard let imageCell = cell.showImageView.image else {
                    return
                }
                let chernobylImageData = imageCell.pngData()
                let imageDownloadedData = Utils.downloadingImageToData(posterUrl: list[0].posterPath)
                XCTAssertEqual(chernobylImageData, imageDownloadedData, "A properly configured CollectionViewCell should display the image of the tv show")
                XCTAssertEqual(cell.nameShowLabel.text, "Chernobyl", "A properly configured CollectionViewCell should display the name of the tv show")
            }
        }
    }

    func testShouldSortTvShows() {
        // Given
        let list = Seed.getTvShowsList()
        let listWithoutSort = Seed.getTvShowsList()
        let viewModel = TvShowsList.Fetch.ViewModel(listTvShows: list)

        // When
        sut?.displayTvShows(viewModel: viewModel)
        sut?.sortTvShows()

        // Then
        XCTAssertNotEqual(listWithoutSort[0].name, sut?.listTvShows[0].name, "Sort list tv shows")
    }
    
    func testErrorDownloadingImageTvShowFromUrl() {
        // Given
        let list = Seed.getTvShowsList()
        
        //When
        let data = Utils.downloadingImageToData(posterUrl: list[1].posterPath)

        // Then
        XCTAssertNil(data, "Error Downloading Image Tv Show from url")
    }
    
    func testShouldDownloadImageTvShowFromUrl() {
        // Given
        let list = Seed.getTvShowsList()
        
        //When
        let data = Utils.downloadingImageToData(posterUrl: list[0].posterPath)

        // Then
        XCTAssertNotNil(data, "Should Download Image Tv Show from url")
    }
}
