//
//  LogTableViewController.swift
//  MedicOnePedsCards
//
//  Created by Sam Gehman on 4/30/18.
//  Copyright © 2018 Sam Gehman. All rights reserved.
//

import UIKit

class LogTableViewController: UITableViewController {

    private let reuseIdentifier = "Cell"
    private static let storyboardIdentifier = "LogTable"

    var entries: [LogEntry]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Display an Edit button in the navigation bar
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(close(_:)))

        // Load the log
        self.entries = Log.log()
    }

    @objc func close(_: Any?) {
        Log.save(entries: entries)
        self.dismiss(animated: true, completion: nil)
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return entries?.count ?? 0
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                                 for: indexPath)

        // Configure the cell...
        if let logEntry = entries?[indexPath.row] {
            cell.textLabel?.text = logEntry.entry.title
            cell.detailTextLabel?.text = logEntry.date
                .description(with: Locale(identifier: "en_US"))
        }

        return cell
    }

    // Support editing the table view
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            entries?.remove(at: indexPath.row)

            // Update the Table View
            tableView.deleteRows(at: [indexPath], with: .fade)
        }

        Log.save(entries: entries)
    }

    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */


    // MARK: - Storyboards

    static func storyboardInstance() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: LogTableViewController.storyboardIdentifier
        )
        return viewController
    }
}
