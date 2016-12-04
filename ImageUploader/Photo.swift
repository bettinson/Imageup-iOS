//
//  Photo.swift
//  ImageUploader
//
//  Created by Matt Bettinson on 2016-12-03.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import Foundation
import UIKit

class Photo {
    let title: String
    let remoteURL: String
    let remoteThumbnailURL: String?
    let photoID: Int
    let dateTaken: Date
    var image : UIImage?
    
    init(title: String, photoID: Int,  remoteURL: String, dateTaken: Date) {
        self.title = title
        self.photoID = photoID
        self.remoteThumbnailURL = "thumbnail-" + remoteURL
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
//        self.image = nil
    }
}
