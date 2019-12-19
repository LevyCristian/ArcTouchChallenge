//
//  QuizView.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 17/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class QuizView: UIView {
    
    // MARK: - Control Variable
    private let keyManager = KeyBoardManager()
    private var footerViewBottomConstraint: NSLayoutConstraint?
    private var footerViewTopConstraint: NSLayoutConstraint?
    private var keywordsTableViewBottomConstraint: NSLayoutConstraint?
    
    var isLoading: Bool = false {
        willSet(newValue) {
            if newValue {
                loadingView.isHidden = false
                loadingView.activyIndicator.startAnimating()
            } else {
                loadingView.isHidden = true
                loadingView.activyIndicator.stopAnimating()
            }
        }
    }
    
    
    // MARK: - UI VAriable
    private lazy var loadingView: LoadingView = {
        let loadingView = LoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
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
    
    // MARK: - Initializatores
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        keyboarHandle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
        keyboarHandle()

    }
    
    // MARK: - Functions
    func keyboarHandle() {
        keyManager.keyboardWillChangeFrame = { [unowned self] isHiding, newHeight, animationDuration, animationCurve in
            
            self.layoutIfNeeded()
            
            self.footerViewBottomConstraint?.constant = -newHeight
            self.footerViewTopConstraint?.isActive = false
            self.keywordsTableViewBottomConstraint?.isActive = false
            
            if isHiding {
                self.footerViewTopConstraint = self.footerView.topAnchor.constraint(equalTo: self.keywordsTableView.bottomAnchor)
                self.keywordsTableViewBottomConstraint = self.footerViewTopConstraint
                self.footerViewTopConstraint?.isActive = true
                self.keywordsTableViewBottomConstraint?.isActive = true
            } else {
                self.footerViewTopConstraint = nil
                self.keywordsTableViewBottomConstraint = self.keywordsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                self.keywordsTableViewBottomConstraint?.isActive = true
            }
            
            UIView.animate(withDuration: animationDuration, delay: 0, options: animationCurve, animations: {
                self.layoutIfNeeded()
            })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let firstTouch = touches.first else {
            return
        }
        
        if firstTouch.view != self.quizTextField {
            self.quizTextField.endEditing(true)
        }
    }
}

extension QuizView : ViewCode {
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(quizTextField)
        addSubview(keywordsTableView)
        addSubview(footerView)
        addSubview(loadingView)
    }
    
    func setupConstraints() {
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
        ])
        
        NSLayoutConstraint.activate([
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        footerViewBottomConstraint = footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        footerViewBottomConstraint?.isActive = true
        
        footerViewTopConstraint = footerView.topAnchor.constraint(equalTo: keywordsTableView.bottomAnchor)
        footerViewTopConstraint?.isActive = true
        
        keywordsTableViewBottomConstraint = footerViewTopConstraint
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        backgroundColor = .white
    }
}
