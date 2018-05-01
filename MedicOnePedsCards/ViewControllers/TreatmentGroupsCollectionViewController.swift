//
//  TreatmentGroupsCollectionViewController.swift
//  MedicOnePedsCards
//
//  Created by Sam Gehman on 4/30/18.
//  Copyright © 2018 Sam Gehman. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TreatmentGroupsCollectionViewController: UICollectionViewController,
UICollectionViewDelegateFlowLayout {

    var colorGroup: ColorGroup!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = colorGroup.title
    }

    override func viewWillAppear(_ animated: Bool) {
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor(hex: colorGroup.color)
    }


    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorGroup.treatmentGroups.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! BigButtonCollectionViewCell

        // Configure the cell
        let treatmentGroup = colorGroup.treatmentGroups[indexPath.item]

        cell.title = treatmentGroup.title
        cell.color = UIColor(hex: colorGroup.color)
        cell.button.didTouchUpInside = { _ in
            self.performTreatmentSegue(forIndexPath: indexPath)
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

        // Calculate width for 1 cell per line
        let totalSpacing = sectionInset.left + sectionInset.right
        let cellWidth = collectionView.bounds.width - totalSpacing
        let cellHeight = cellWidth / 5

        return CGSize(width: cellWidth, height: cellHeight)
    }

    
    // MARK: - Navigation

    var selectedTreatmentGroup: ColorGroup.TreatmentGroup?

    func performTreatmentSegue(forIndexPath indexPath: IndexPath) {
        self.selectedTreatmentGroup = colorGroup.treatmentGroups[indexPath.item]
        performSegue(withIdentifier: "TreatmentSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let treatment = segue.destination as! TreatmentTableViewController
        treatment.colorGroup = colorGroup
        treatment.treatmentGroup = selectedTreatmentGroup
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return selectedTreatmentGroup != nil
    }
}
