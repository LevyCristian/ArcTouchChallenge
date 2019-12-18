//
//  FooterView.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 17/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class FooterView: UIView {

    lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.applyFont(ofSize: 34, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.applyFont(ofSize: 34, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var quizButton: QuizButton = {
        let button = QuizButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var separatorLineView: UIView = {
        let line = UIView()
        line.backgroundColor = .gray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
}

extension FooterView: ViewCode {
    func buildViewHierarchy() {
        addSubview(counterLabel)
        addSubview(timerLabel)
        addSubview(quizButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            counterLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            counterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            quizButton.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 16),
            quizButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            quizButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            quizButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)

        ])
    }
    
    func setupAdditionalConfigurantion() {
        backgroundColor = .backgroundColor
    }
    
    
}
