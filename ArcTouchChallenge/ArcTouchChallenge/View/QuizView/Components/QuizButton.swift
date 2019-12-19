//
//  QuizButton.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 17/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class QuizButton: UIButton {
    
    var title: String? {
        willSet(newValue) {
            setTitle(newValue, for: .normal)
        }
    }
    
    // MARK: - Initializer & functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        titleLabel?.font = UIFont.applyFont(ofSize: 17, weight: .semiBold)
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 0
        contentHorizontalAlignment = .center
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = .actionColor
    }
    
}
