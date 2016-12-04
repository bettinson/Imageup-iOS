//
//  PhotoCollectionViewCell.swift
//  ImageUploader
//
//  Created by Matt Bettinson on 2016-12-03.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func updateWithImage(image: UIImage?) {
        if let imageToDisplay = image {
            imageView.image = imageToDisplay
        } else {
            imageView.image = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateWithImage(image: nil)
    }
    
    // Depracated.
//    func updateProgress(progress : Double) {
//        if (progress == 1) {
//            progressView.isHidden = true
//        }
//        progressView.progress = Float(progress)
//    }
//    
    override func prepareForReuse() {
        super.prepareForReuse()
        updateWithImage(image: nil)
    }
}
