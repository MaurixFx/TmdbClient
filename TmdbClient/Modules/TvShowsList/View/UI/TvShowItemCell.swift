//
//  TvShowItemCell.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 07-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit
import SDWebImage

class TvShowItemCell: UICollectionViewCell {
    
    // MARK: Create UIImageView
    let showImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: Create UILabel
    let nameShowLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: init Cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Cell
    private func setupCell() {
        backgroundColor = .clear
        addComponentsInCell()
        setupConstraints()
    }
    
    private func addComponentsInCell() {
        addSubview(showImageView)
        addSubview(nameShowLabel)
    }
    
    private func setupConstraints() {
        showImageView.anchor(
            top: topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 8,
            paddingLeft: 8,
            paddingRight: 8,
            height: frame.height * 0.85
        )
        
        nameShowLabel.anchor(
            top: showImageView.bottomAnchor,
            left: showImageView.leftAnchor,
            right: showImageView.rightAnchor,
            bottom: bottomAnchor,
            paddingTop: 8,
            paddingBottom: 5
        )
    }
    
    // MARK: Display Info
    func displayInfo(tvShow: TvShows) {
        nameShowLabel.text = tvShow.name
        displayImageTvShow(path: tvShow.posterPath)
    }
    
    private func displayImageTvShow(path: String) {
        guard let url = Utils.getUrlImageTvShow(posterUrl: path) else {
            return
        }
        showImageView.sd_setImage(with: url, placeholderImage: nil, options: .progressiveLoad, context: nil)
    }
    
}
