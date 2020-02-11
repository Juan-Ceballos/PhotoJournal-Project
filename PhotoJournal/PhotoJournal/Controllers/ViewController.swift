//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Juan Ceballos on 1/27/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoJournalVC: UIViewController {
    
    @IBOutlet weak var photoJournalCollectionView: UICollectionView!
        
    private var photos = [PhotoObject]()
    
    private let imagePickerController = UIImagePickerController()
    
    private let dataPersistence = PersistenceHelper(filename: "photos.plist")
    
    private var selectedImage: UIImage? {
        didSet  {
            appendNewPhotoCollection()
        }
    }
    
    var selectedText: String?   {
        didSet  {
            appendNewPhotoCollection()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        photoJournalCollectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "editablePhotoCell")
        photoJournalCollectionView.dataSource = self
        photoJournalCollectionView.delegate = self
        loadImageObjects()
        photoJournalCollectionView.backgroundColor = .systemTeal
    }
    
    private func appendNewPhotoCollection() {
        guard let image = selectedImage
            else    {
                print("image is nil")
                return
            }
        
        let comment = selectedText ?? "hey"
        
        
        let size = UIScreen.main.bounds.size
        
        // we will maintain the aspoect ratio of the image
        let rect = AVMakeRect(aspectRatio: CGSize(width: 1080, height: 1080), insideRect: CGRect(origin: CGPoint.zero, size: size))
        let resizeImage = image.resizeImage(to: rect.size.width * 0.25, height: rect.size.height * 0.2)
        
        guard let resizedImageData = resizeImage.jpegData(compressionQuality: 1.0)
            else    {
                return
        }
        
        let photoObject = PhotoObject(imageData: resizedImageData, date: Date(), photoComment: comment)
        
        // insert new imageObject into imageObjects
        photos.insert(photoObject, at: 0)
        
        // create an indexPath for insertion into collection view
        let indexPath = IndexPath(row: 0, section: 0)
        
        // insert new cell into collection view
        photoJournalCollectionView.insertItems(at: [indexPath])
        
        // persist imageObject to documents directory
        do  {
            try dataPersistence.create(event: photoObject)
        }
        catch   {
            print("saving error \(error)")
        }
    }
    
    
    @IBAction func addButtonPressed()   {
        guard let addPhotoController = storyboard?.instantiateViewController(identifier: "AddPhotoController") as? AddPhotoController
            else    {
                fatalError()
        }
        present(addPhotoController, animated: true)
        addPhotoController.photoSelectedDelegate = self
        addPhotoController.photoCommentDelagate = self
    }
    
    
    
    private func loadImageObjects() {
        do  {
            photos = try dataPersistence.loadPhotos()
        }
        catch   {
            print("loading error")
        }
    }
    
    
}

extension PhotoJournalVC: UICollectionViewDelegateFlowLayout    {
    
}

extension PhotoJournalVC: UICollectionViewDataSource    {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "editablePhotoCell", for: indexPath) as? PhotoCell
            else    {
                fatalError()
        }
        let photoObject = photos[indexPath.row]
        cell.configureCell(photoObject: photoObject)
        cell.backgroundColor = .systemOrange
        cell.buttonPressedDelegate = self
        return cell
    }
    
}

extension UIImage {
    func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension PhotoJournalVC: PhotoSelectedDelegate {
    func adjustPhoto(_ photo: UIImage) {
        selectedImage = photo
    }
}

extension PhotoJournalVC: PhotoCommentDelegate  {
    func adjustComment(_ photoObject: String) {
        selectedText = photoObject
    }
}

extension PhotoJournalVC: ButtonPressedDelegate {
    func alertPressed(_ pressed: PhotoCell) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(title: "Edit", style: .default) { [weak self] alertAction in
            
            guard let addPhotoController = self?.storyboard?.instantiateViewController(identifier: "AddPhotoController") as? AddPhotoController
                else    {
                    fatalError()
            }
            
            self?.present(addPhotoController, animated: true)
            addPhotoController.selectedImage = pressed.photoImage.image
            addPhotoController.postTextView.text = pressed.photoComment.text
            addPhotoController.postTextView.textColor = .black
            addPhotoController.photoLibraryButton.isEnabled = false
            addPhotoController.photoSelectedDelegate = self
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] alertAction in
            
        }
        
        alertController.addAction(editAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}

