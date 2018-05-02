//
//  BigButtonCollectionViewCell.swift
//  MedicOnePedsCards
//
//  Created by Sam Gehman on 4/27/18.
//  Copyright © 2018 Sam Gehman. All rights reserved.
//

import UIKit

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

    public var subtitle: String {
        get {
            return button.subtitleString
        }
        set(newSubtitle) {
            button.subtitleString = newSubtitle
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

            button.gradientStartColor = endColor
            button.gradientEndColor = endColor
        }
    }

    override func prepareForReuse() {
        button.didTouchUpInside = nil
    }
}

extension UIColor {
    var hsba:(h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h: h, s: s, b: b, a: a)
    }
}
