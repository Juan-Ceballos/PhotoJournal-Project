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
        }
    }
    
    var currentEnteredText = ""    {
        didSet  {
            postTextView.text = currentEnteredText
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        postTextView.delegate = self
        postTextView.text = "Say Something"
        postTextView.textColor = .systemGray
        checkForEmptyTextView()
        saveButton.isEnabled = false
    }
    
    func checkForEmptyTextView()   {
        if postTextView.text == ""  {
            postTextView.text = "Say Something"
            postTextView.textColor = .systemGray
        }
    }
    
    func saveStatus()   {
        if selectedImage == UIImage(named: "photo.fill") || postTextView.text == "Say Something" || postTextView.text == ""   {
            saveButton.isEnabled = false
        }
        else    {
            saveButton.isEnabled = true
        }
    }
    
    @IBAction func photoLibraryButtonPressed(_ sender: UIBarButtonItem)    {
        showImageController(isCameraSelected: false)
    }
    
    @IBAction func cancelButtonPressed(_sender: UIButton)   {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton)  {
        photoSelectedDelegate?.adjustPhoto(selectedImage!)
        dismiss(animated: true)
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
        checkForEmptyTextView()
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
        dismiss(animated: true)
        checkForEmptyTextView()
        saveStatus()
    }
}

extension AddPhotoController: UITextViewDelegate   {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Say Something" && textView.textColor == .systemGray    {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        saveStatus()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
