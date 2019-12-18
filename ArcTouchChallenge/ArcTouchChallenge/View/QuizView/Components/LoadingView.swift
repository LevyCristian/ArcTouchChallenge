//
//  LoadingView.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 17/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var activyIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .whiteLarge
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.font = UIFont.applyFont(ofSize: 17, weight: .semiBold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        activyIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
}

extension LoadingView: ViewCode {
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(activyIndicator)
        containerView.addSubview(loadingLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),
            containerView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            activyIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activyIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activyIndicator.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.05),
            activyIndicator.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.05)
        ])
        
        NSLayoutConstraint.activate([
            loadingLabel.topAnchor.constraint(equalTo: activyIndicator.bottomAnchor),
            loadingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            loadingLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            loadingLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -6)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
}
