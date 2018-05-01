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
    @IBOutlet weak var button: LGButton!

    public var title: String {
        get {
            return button.titleString
        }
        set(newTitle) {
            button.titleString = newTitle
        }
    }

    public var color: UIColor? {
        get {
            return button.gradientEndColor
        }
        set(color) {
            guard let endColor = color else {
                return
            }

            // Get HSV from new endColor
            let saturationDelta: CGFloat = 0.4
            let startColor = UIColor(hue: endColor.hsba.h,
                                     saturation: max(endColor.hsba.s - saturationDelta, 0),
                                     brightness: endColor.hsba.b,
                                     alpha: 1)
            button.gradientStartColor = startColor
            button.gradientEndColor = endColor
        }
    }
}

extension UIColor {
    var hsba:(h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h: h, s: s, b: b, a: a)
    }
}
