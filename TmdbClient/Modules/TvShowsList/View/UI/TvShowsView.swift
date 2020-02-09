//
//  TvShowsView.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 06-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

class TvShowsView: UIView {
    
    // MARK: Create UICollectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TvShowItemCell.self, forCellWithReuseIdentifier: AppKeys.Cells.tvShows)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = false
        collection.backgroundColor = .clear
        
        return collection
    }()
    
    // MARK: Init View
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Setup View
    private func setupView() {
        backgroundColor = .white
        addComponentsInView()
        setupConstraints()
    }
    
    private func addComponentsInView() {
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.fillSuperview()
    }
}
