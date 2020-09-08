//
//  NoteListViewController.swift
//  planner
//
//  Created by Сергей Петров on 02.08.2020.
//  Copyright © 2020 SergioPetrovx. All rights reserved.
//

import UIKit
import CoreData


class NoteListViewController: UIViewController {

    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    var notesData: [Note] = []
    let cellID = "NoteCell"
    let insets = UIEdgeInsets(top: 0, left: 5, bottom: 69, right: 5)
    
    let data = [
        UIColor.green,
        UIColor.yellow,
        UIColor.brown
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
    }
    
    func collectionViewSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
//        collectionView.register(NoteCell.self, forCellWithReuseIdentifier: cellID)
//        collectionView.isPagingEnabled = true
    }
}


extension NoteListViewController: UICollectionViewDelegate {
    
}


extension NoteListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count * 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? NoteCell else {
            return UICollectionViewCell()
        }
        let color = data[indexPath.item % 3]
        cell.setup(color: color)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
}


extension NoteListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 10 - insets, 5 - between cols
        let width: CGFloat = collectionView.frame.width / 8
        let height: CGFloat = collectionView.frame.height / 6
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}
