//
//  ColorGroup.swift
//  MedicOnePedsCards
//
//  Created by Sam Gehman on 4/29/18.
//  Copyright © 2018 Sam Gehman. All rights reserved.
//

import UIKit

struct Log {

    public static let filename = "log.json"

    static func url() -> URL {
        return FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent(filename)
    }

    static func log() -> [LogEntry]? {
        let logUrl = Log.url()

        let decoder = JSONDecoder()
        let entries = try? decoder.decode([LogEntry].self, from: Data(contentsOf: logUrl))

        return entries
    }

    static func save(entries: [LogEntry]?) {
        guard let entries = entries else {
            return
        }

        let logUrl = Log.url()

        let encoder = JSONEncoder()
        let entriesJson = try! encoder.encode(entries)
        try! entriesJson.write(to: logUrl) // FIXME: can this fail?
    }

    static func append(entry: LogEntry) {
        var entries = log() ?? [LogEntry]()
        entries.append(entry)
        save(entries: entries)
    }
}

struct LogEntry {
    let entry: ColorGroup.TreatmentGroup.Treatment.Entry
    let date: Date
}

struct ColorGroup: Codable {
    public static let localFilename = "medicone"

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
}
