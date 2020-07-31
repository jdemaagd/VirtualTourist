//
//  AlbumViewController+CollectionView.swift
//  VirtualTourist
//
//  Created by JON DEMAAGD on 7/30/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - collection view methods
    
    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        configureFlowLayout()
    }
    // Consider using Access Modifiers here :D They enable you to hide the implementation details of your code and to specify a preferred interface through which that code can be accessed and used.
    

    func configureFlowLayout() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let space:CGFloat = 3.0
            let dimension = (view.frame.size.width - (2 * space)) / 3.0
            flowLayout.minimumInteritemSpacing = space
            flowLayout.minimumLineSpacing = space
            flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        }
    }
    
    
    // MARK: - Delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = fetchedResultsController.sections?[section].numberOfObjects ?? 0
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumViewCell.reuseIdentifier, for: indexPath as IndexPath) as! AlbumViewCell
        guard !(self.fetchedResultsController.fetchedObjects?.isEmpty)! else {
            print("images are already present.")
            return cell
        }
    
        let photoData = self.fetchedResultsController.object(at: indexPath)
        
        if photoData.imageData == nil {
            newCollectionButton.isEnabled = false
            DispatchQueue.global(qos: .background).async {
                if let imageData = try? Data(contentsOf: photoData.imageUrl!) {
                    DispatchQueue.main.async {
                        photoData.imageData = imageData
                        do {
                            try self.dataController.viewContext.save()
                        } catch {
                            print("error in saving image data")
                        }
                        
                        let image = UIImage(data: imageData)!
                        cell.setPhotoImageView(imageView: image, sizeFit: true)
                    }
                }
            }
        } else {
            if let imageData = photoData.imageData {
                let image = UIImage(data: imageData)!
                cell.setPhotoImageView(imageView: image, sizeFit: false)
            }
        }
        newCollectionButton.isEnabled = true
        
        return cell
    }
}
