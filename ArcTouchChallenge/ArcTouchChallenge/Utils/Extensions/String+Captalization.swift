//
//  String+Captalization.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 17/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation

extension String {
    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
}
