//
//  PostService.swift
//  XPosure2
//
//  Created by Henrik Wollersheim on 26.09.17.
//  Copyright © 2017 idek Ltd. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

struct PostService {
    
    //MARK: - Methods
    
    
    static func create(for image: UIImage) {
        
        let imageRef = Storage.storage().reference().child("test_image.jpg")
        
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            
            let urlString = downloadURL.absoluteString
            
            print("image url: \(urlString)")
        }
        
    }
    
    
}
