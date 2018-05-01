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
        return 0;
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }

    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        // TODO
    }
}
