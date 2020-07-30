//
//  AlbumViewCell.swift
//  VirtualTourist
//
//  Created by JON DEMAAGD on 7/30/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

class AlbumViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!

    static let reuseIdentifier = K.albumViewCellId
    

    func setPhotoImageView(imageView: UIImage, sizeFit: Bool) {
        photoImageView.image = imageView
        if sizeFit == true {
            photoImageView.sizeToFit()
        }
    }
}
