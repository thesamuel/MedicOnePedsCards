//
//  ColorGroup.swift
//  MedicOnePedsCards
//
//  Created by Sam Gehman on 4/29/18.
//  Copyright © 2018 Sam Gehman. All rights reserved.
//

import UIKit

struct ColorGroup: Codable {
    let title: String
    let lbs: Int
    let kgs: Int
    let color: String
    let vitalsAndEquipment: VitalsAndEquipment
    let treatmentGroups: [TreatmentGroup]

    struct VitalsAndEquipment: Codable {
        let approximateAge: Int
        let heartRateRange: [Int]
        let respiratoryRange: [Int]
        let minimumSBP: Int

        let fluidBolus: Int
        let ettSize: Double
        let ettDepth: Double
        let suctionCath: Int
    }

    struct TreatmentGroup: Codable {
        let title: String
        let treatments: [Treatment]

        struct Treatment: Codable {
            let title: String
            let entries: [Entry]

            struct Entry: Codable {
                // TODO: allow for calculating these values
                let title: String
                let dose: String
                let amount: String
                let vol: String
            }
        }
    }
}

// Taken from https://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values
extension UIColor {
    convenience init(hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        assert(cString.count == 6, "Incorrect number of hex digits in color")

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

//    convenience init(red: Int, green: Int, blue: Int) {
//        assert(red >= 0 && red <= 255, "Invalid red component")
//        assert(green >= 0 && green <= 255, "Invalid green component")
//        assert(blue >= 0 && blue <= 255, "Invalid blue component")
//
//        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
//    }
//
//    convenience init(rgb: Int) {
//        self.init(
//            red: (rgb >> 16) & 0xFF,
//            green: (rgb >> 8) & 0xFF,
//            blue: rgb & 0xFF
//        )
//    }
}
