//
//  BigButtonCollectionViewCell.swift
//  MedicOnePedsCards
//
//  Created by Sam Gehman on 4/27/18.
//  Copyright © 2018 Sam Gehman. All rights reserved.
//

import UIKit
import LGButton

class BigButtonCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var button: LGButton!

    public var title: String {
        get {
            return button.titleString
        }
        set {
            button.titleString = newValue
        }
    }

    public var color: UIColor? {
        get {
            return button.gradientEndColor
        }
        set {
            // FIXME
            button.gradientStartColor = newValue
            button.gradientEndColor = newValue
        }
    }
}
