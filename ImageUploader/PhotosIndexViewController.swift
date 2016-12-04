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

class PhotosIndexViewController : UIViewController {
    var store : PhotoStore!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        collectionView.dataSource = store
    }
    
    func setup() {
        // Get recent photos
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
            self.collectionView.reloadData()
        }
    
        
//        Alamofire.request("http://104.131.50.247/i/" + data[0]["path"].string!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:])
//            .responseJSON { response in
//                let image = UIImage(data: response.data!)
//                self.imageView.image = image
//        }
    }
}