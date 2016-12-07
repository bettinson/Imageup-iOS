//
//  PhotosIndexViewController.swift
//  ImageUploader
//
//  Created by Matt Bettinson on 2016-12-03.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PhotosIndexViewController : UIViewController, UICollectionViewDelegate {
    var store : PhotoStore!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = store

        setup()
    }
    
    // Grabs the JSON data from the index page
    func setup() {
        Alamofire.request(ImageUploaderAPI.recentPhotosUrl(), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON { response in
            let responseJSON = JSON(response.result.value ?? JSON.null)
            if (responseJSON != JSON.null) {
                if let items = responseJSON.array {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    for item in items {
                        // Date needs to be handled differently.
                        let date = dateFormatter.date(from: item["created_at"].string!)
                        // Thumbnail path could be nil
                        let photo = Photo(title: item["title"].string!,
                                      photoID: item["id"].int!,
                                      remoteURL: item["path"].string!,
                                      dateTaken: date!)
                        self.store.photos.append(photo)
                    }
                }
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        downloadImageFor(indexPath: indexPath)
        let identifier = "UICollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotoCollectionViewCell
        let photo = store.photos[indexPath.row]
        
        cell.imageView.image = photo.image
    }
}
