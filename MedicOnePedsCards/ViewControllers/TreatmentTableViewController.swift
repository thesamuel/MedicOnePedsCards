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

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        // Do any additional setup after loading the view.
        self.navigationItem.title = treatmentGroup.title
    }

    override func viewWillAppear(_ animated: Bool) {
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor(hex: colorGroup.color)
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
                                                 for: indexPath)

        // Configure the cell
        let entry = treatmentGroup.treatments[indexPath.section].entries[indexPath.row]

        // TODO: add the rest!
        cell.textLabel?.text = entry.title

        return cell
    }
}
