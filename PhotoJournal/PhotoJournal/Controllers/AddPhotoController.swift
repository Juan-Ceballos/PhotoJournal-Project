//
//  AddPhotoController.swift
//  PhotoJournal
//
//  Created by Juan Ceballos on 1/30/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

protocol PhotoSelectedDelegate: AnyObject {
    func adjustPhoto(_ photo: UIImage)
}

class AddPhotoController: UIViewController {
    
    @IBOutlet weak var editablePhoto: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var postTextView: UITextView!
    
    weak var photoSelectedDelegate: PhotoSelectedDelegate?
    
    private let imagePickerController = UIImagePickerController()
    
    var selectedImage: UIImage? {
        didSet  {
            editablePhoto.image = selectedImage
            photoSelectedDelegate?.adjustPhoto(selectedImage!)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
    }
    
    @IBAction func photoLibraryButtonPressed(_ sender: UIBarButtonItem)    {
        showImageController(isCameraSelected: false)
    }
    
    private func showImageController(isCameraSelected: Bool)  {
        // source type default wiil be .photoLibrary
        imagePickerController.sourceType = .photoLibrary
        if isCameraSelected {
            imagePickerController.sourceType = .camera
        }
        present(imagePickerController, animated: true)
    }
    
}

extension AddPhotoController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // we need to access the UIIMagePickerController.InfoKey.originalImage key to get the
        // UIImage that was selected
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            else    {
                print("Image Selection Not Found")
                return
        }
        selectedImage = image
    }
}
