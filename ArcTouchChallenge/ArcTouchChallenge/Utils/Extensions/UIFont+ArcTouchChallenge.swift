//
//  UIFont+ArcTouchChallenge.swift
//  ArcTouchChallenge
//
//  Created by Levy Cristian on 17/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation

import UIKit

enum AppFontVariantions: String {
    case bold = "-Bold"
    case regular = "-Regular"
    case semiBold = "-SemiBold"
}

extension UIFont {
    static func applyFont(ofSize size : CGFloat, weight variation : AppFontVariantions ) -> UIFont? {
        return UIFont(name: "SFProDisplay\(variation.rawValue)", size: size)
    }
}
