//
//  PhotoCell.swift
//  PhotoJournal
//
//  Created by Juan Ceballos on 1/27/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

protocol ButtonPressedDelegate: AnyObject   {
    func alertPressed(_ pressed: PhotoCell)
}

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var photoComment: UILabel!
    @IBOutlet weak var photoDatePosted: UILabel!
    @IBOutlet weak var eidtButton: UIButton!
    
    weak var buttonPressedDelegate: ButtonPressedDelegate?
    
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        buttonPressedDelegate?.alertPressed(self)
    }
    
    func configureCell(photoObject: PhotoObject)    {
        guard let photo = UIImage(data: photoObject.imageData)
            else    {
                return
        }
        
        let photo2 = photoObject.photoComment
            
        photoImage.image = photo
        photoComment.text = photo2
        photoComment.font = .boldSystemFont(ofSize: 20)
        photoDatePosted.text = photoObject.convertedDate
        
    }
}


