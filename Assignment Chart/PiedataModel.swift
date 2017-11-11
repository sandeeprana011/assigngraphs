//
// Created by Sandeep Rana on 11/11/17.
// Copyright (c) 2017 thedancho. All rights reserved.
//

import Foundation
import UIKit

class PiedataModel {

    /// Data value
    public var value: CGFloat = 0.0

    /// Color displayed on chart
    public var color: UIColor = UIColor.black;

    /// Description text
    public var description: String?

    public init(value: CGFloat, color: UIColor, description: String?) {
        self.value = value
        self.color = color
        self.description = description
    }
}
