//
//  UIColor++.swift
//  ARKitPhysics
//
//  Created by peo on 2022/08/26.
//  Copyright © 2022 AppCoda. All rights reserved.
//

import UIKit

extension UIColor {
    static var random: UIColor? {
        get {
            return [UIColor.red, UIColor.green, UIColor.blue, UIColor.black, UIColor.purple, UIColor.brown]
                .randomElement()
        }
    }
}
