//
//  KeywordCellViewModel.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 18/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation

struct KeywordCellViewModel {
    
    // MARK: - Properties
    private let keyword: String
    
    // MARK: - Output strings
    public var keywordText: String {
        return keyword.firstCapitalized
    }
    
    // MARK: - Initializer
    init(keyword: String) {
        self.keyword = keyword
    }
}
