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
        
        let imageRef = StorageReference.newPostImageReference()
        
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            
            let urlString = downloadURL.absoluteString
            let aspectHeight = image.aspectHeight
            create(forURLString: urlString, aspectHeight: aspectHeight)
        }
        
    }
    
    private static func create(forURLString urlString: String, aspectHeight: CGFloat) {
        
        let currentUser = User.current
        
        let post = Post(imageURL: urlString, imageHeight: aspectHeight)
        
        let dict = post.dictValue
        
        let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
        
        postRef.updateChildValues(dict)
        
    }
    
    
}
