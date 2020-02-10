//
//  PhotoCell.swift
//  PhotoJournal
//
//  Created by Juan Ceballos on 1/27/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

protocol ButtonPressedDelegate: AnyObject   {
    func alertPressed(_ pressed: Bool)
}

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var photoComment: UILabel!
    @IBOutlet weak var photoDatePosted: UILabel!
    @IBOutlet weak var eidtButton: UIButton!
    
    weak var buttonPressedDelegate: ButtonPressedDelegate?
    
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        
        buttonPressedDelegate?.alertPressed(true)
//
//        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//
//            let editAction = UIAlertAction(title: "Edit", style: .default) { [weak self] alertAction in
//
//                self?.showImageController(isCameraSelected: false)
//            }
//
//            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
//
//            alertController.addAction(editAction)
//            alertController.addAction(cancelAction)
//            present(alertController, animated: true)
//        }
//
//        private func showImageController(isCameraSelected: Bool)  {
//            // source type default wiil be .photoLibrary
//            imagePickerController.sourceType = .photoLibrary
//            if isCameraSelected {
//                imagePickerController.sourceType = .camera
//            }
//            present(imagePickerController, animated: true)
//        }
    }
    
    func configureCell(photoObject: PhotoObject)    {
        guard let photo = UIImage(data: photoObject.imageData)
            else    {
                return
        }
        photoImage.image = photo
        photoComment.text = UserInfo.shared.getComment()
        photoComment.font = .boldSystemFont(ofSize: 20)
        photoDatePosted.text = photoObject.convertedDate
        
    }
}


