//
//  PhotoCell.swift
//  PhotoJournal
//
//  Created by Juan Ceballos on 1/27/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var photoComment: UILabel!
    @IBOutlet weak var photoDatePosted: UILabel!
    
    
    
    func configureCell(photoObject: PhotoObject)    {
        guard let photo = UIImage(data: photoObject.imageData)
            else    {
                return
        }
        photoImage.image = photo
        photoComment.text = UserInfo.shared.getComment()
    }
}


