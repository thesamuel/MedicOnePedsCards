//
//  ColorsCollectionViewController.swift
//  MedicOnePedsCards
//
//  Created by Sam Gehman on 4/27/18.
//  Copyright © 2018 Sam Gehman. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ColorsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var colorGroups: [ColorGroup]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Additional setup
        loadColorGroups()
    }

    override func viewWillAppear(_ animated: Bool) {
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = .white
    }
    
    func loadColorGroups() {
        let jsonUrl = Bundle.main.url(forResource: ColorGroup.localFilename, withExtension: "json")!
        let jsonData = try! Data(contentsOf: jsonUrl)
        let jsonDecoder = JSONDecoder()

        // Update color groups
        self.colorGroups = try! jsonDecoder.decode([ColorGroup].self, from: jsonData)
    }


    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return colorGroups.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! BigButtonCollectionViewCell
    
        // Configure the cell
        let colorGroup = colorGroups[indexPath.item]

        cell.title = colorGroup.title
        cell.color = UIColor(hex: colorGroup.color)  // FIXME
        cell.button.didTouchUpInside = { _ in
            self.performTreatmentGroupsSegue(forIndexPath: indexPath)
        }

        return cell
    }


    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Set size for each cell
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let sectionInset = layout.sectionInset

        // Calculate width for 2 cells per line
        let totalSpacing = sectionInset.left + sectionInset.right + layout.minimumInteritemSpacing
        let totalContentWidth = collectionView.bounds.width - totalSpacing

        let cellWidth = totalContentWidth / 2
        let cellHeight = cellWidth / 1.75

        return CGSize(width: cellWidth, height: cellHeight)
    }


    // MARK: - Navigation

    var selectedColorGroup: ColorGroup?

    func performTreatmentGroupsSegue(forIndexPath indexPath: IndexPath) {
        self.selectedColorGroup = colorGroups[indexPath.item]
        performSegue(withIdentifier: "TreatmentGroupsSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let treatmentGroups = segue.destination as! TreatmentGroupsCollectionViewController
        treatmentGroups.colorGroup = selectedColorGroup
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return selectedColorGroup != nil
    }
}
