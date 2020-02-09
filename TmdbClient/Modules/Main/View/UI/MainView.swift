//
//  MainView.swift
//  TmdbClient
//
//  Created by Mauricio Figueroa olivares on 06-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    // MARK: Create UIButton
    lazy var goButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("GO", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
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
        addSubview(goButton)
        goButton.anchor(
            width: frame.width * 0.40,
            height: 35
        )
        
        goButton.centerInSuperview()
    }
    
}
