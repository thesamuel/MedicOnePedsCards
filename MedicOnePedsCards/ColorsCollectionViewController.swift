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

    func loadColorGroups() {
        let jsonUrl = Bundle.main.url(forResource: "colorgroups", withExtension: "json")!
        let jsonData = try! Data(contentsOf: jsonUrl)
        let jsonDecoder = JSONDecoder()

        // Update color groups
        self.colorGroups = try! jsonDecoder.decode([ColorGroup].self, from: jsonData)
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return colorGroups.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! BigButtonCollectionViewCell
    
        // Configure the cell
        let colorGroup = colorGroups[indexPath.item]
        cell.title = colorGroup.title

        // FIXME: should be done already!
        cell.color = UIColor(hex: colorGroup.color)

        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Set size for each cell
        let width = collectionView.bounds.width / 2
        let height = width / 1.75

        return CGSize(width: width, height: height);
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;  // FIXME
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */

    // MARK: - UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
}
