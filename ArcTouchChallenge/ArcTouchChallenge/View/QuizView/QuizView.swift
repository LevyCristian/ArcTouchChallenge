//
//  QuizView.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 17/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class QuizView: UIView {
    
    var isLoading: Bool = false {
        didSet(newValue) {
            if newValue {
                loadingView.isHidden = false
                loadingView.activyIndicator.startAnimating()
            } else {
                loadingView.isHidden = true
                loadingView.activyIndicator.startAnimating()
            }
        }
    }
    
    private lazy var loadingView: LoadingView = {
        let loadingView = LoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What are all the java keywords?"
        label.font = UIFont.applyFont(ofSize: 34, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var quizTextField: UITextField = {
        let textField = QuizTextField()
        textField.placeholder = "Insert Word"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var keywordsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.showsHorizontalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        return tableView
    }()
    
    lazy var footerView: FooterView = {
        let footer = FooterView()
        footer.translatesAutoresizingMaskIntoConstraints = false
        return footer
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

extension QuizView : ViewCode {
    func buildViewHierarchy() {
        addSubview(loadingView)
        addSubview(titleLabel)
        addSubview(quizTextField)
        addSubview(keywordsTableView)
        addSubview(footerView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            quizTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            quizTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            quizTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            quizTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            keywordsTableView.topAnchor.constraint(equalTo: quizTextField.bottomAnchor, constant: 16),
            keywordsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            keywordsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            keywordsTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -135)
            
        ])
        
        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(equalTo: keywordsTableView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 135)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        backgroundColor = .white
    }
}
