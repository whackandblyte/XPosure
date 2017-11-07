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
        
        let rootRef = Database.database().reference()
        
        let newPostRef = rootRef.child("posts").child(currentUser.uid).childByAutoId()
        
        let newPostKey = newPostRef.key
        
        
        UserService.followers(for: currentUser) { (followerUIDs) in
            
            let timelinePostDict = ["poster_uid" : currentUser.uid]
            
            var updatedData: [String : Any] = ["timeline/\(currentUser.uid)/\(newPostKey)" : timelinePostDict]
            
            for uid in followerUIDs {
                updatedData["timeline/\(uid)/\(newPostKey)"] = timelinePostDict
            }
            
            let postDict = post.dictValue
            
            updatedData["posts/\(currentUser.uid)/\(newPostKey)"] = postDict
            
            rootRef.updateChildValues(updatedData)
            
        }
        
        
        /*
        
        let dict = post.dictValue
        
        let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
        
        postRef.updateChildValues(dict)
 
        */
        
    }
    
    
}
