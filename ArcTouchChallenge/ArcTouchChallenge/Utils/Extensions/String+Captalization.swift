//
//  String+Captalization.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 17/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation

extension String {
    /**
       Varialble to captilize the frist character of a string
     - Returns: a self string with the frist character captilized
    */
    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
}
