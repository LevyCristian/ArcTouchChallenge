//
//  QuizTextField.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 17/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class QuizTextField: UITextField {
    
    // MARK: - Initializer & functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    
    func setupTextField() {
        backgroundColor = UIColor.backgroundColor
        font = UIFont.applyFont(ofSize: 17, weight: .regular)
        borderStyle = .none
        layer.masksToBounds = true
        layer.cornerRadius = 8.0
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: frame.height))
        leftViewMode = UITextField.ViewMode.always
    }
}
