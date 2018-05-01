//
//  TreatmentTableViewController.swift
//  MedicOnePedsCards
//
//  Created by Sam Gehman on 4/30/18.
//  Copyright © 2018 Sam Gehman. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TreatmentTableViewController: UITableViewController {

    var colorGroup: ColorGroup!
    var treatmentGroup: ColorGroup.TreatmentGroup!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = treatmentGroup.title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(openLog(_:)))
    }

    override func viewWillAppear(_ animated: Bool) {
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor(hex: colorGroup.color)
    }

    @objc func openLog(_: Any?) {
        let viewController = LogTableViewController.storyboardInstance()
        present(viewController, animated: true, completion: nil)
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Each treatment is a section
        return treatmentGroup.treatments.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return treatmentGroup.treatments[section].title
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Within each treatment (displayed as a section) are entries, which are displayed as rows
        return treatmentGroup.treatments[section].entries.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, 
                                                 for: indexPath) as! EntryTableViewCell

        // Configure the cell
        let entry = treatmentGroup.treatments[indexPath.section].entries[indexPath.row]

        cell.treatmentLabel.text = entry.title
        cell.amountLabel.text = "Amt: " + entry.amount
        cell.doseLabel.text = "Dose: " + entry.dose
        cell.volumeLabel.text = "Vol: " + entry.vol
        cell.administerButton.layer.cornerRadius = 4  // FIXME
        // TODO: add IM/IN field

        return cell
    }
}
