//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Juan Ceballos on 1/27/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class PhotoJournalVC: UIViewController {
    
    @IBOutlet weak var photoJournalCollectionView: UICollectionView!
    

    private var photos = [PhotoObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoJournalCollectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "editablePhotoCell")
        photoJournalCollectionView.dataSource = self
    }

}

extension PhotoJournalVC: UICollectionViewDelegateFlowLayout    {
    
}


extension PhotoJournalVC: UICollectionViewDataSource    {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "editablePhotoCell", for: indexPath) as? PhotoCell
            else    {
                fatalError()
        }
        
        let photoObject = photos[indexPath.row]
        cell.configureCell(photoObject: photoObject)
        return cell
    }
    
    
}

