//
//  LikeService.swift
//  XPosure2
//
//  Created by Henrik Wollersheim on 05.10.17.
//  Copyright © 2017 idek Ltd. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct LikeService {
    
    
    // Create a new like, add the corresponding data to a new post in the Database, and increment the like Counter.
    static func create(for post: Post, success: @escaping (Bool) -> Void) {
        
        guard let key = post.key else {
            return success(false)
        }
        
        let currentUID = User.current.uid
        
        // Create a Reference to the Database path at which the like should be saved
        let likesRef = Database.database().reference().child("postLikes").child(key).child(currentUID)
        
        likesRef.setValue(true) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return success(false)
            }
            
            let likeCountRef = Database.database().reference().child("posts").child(post.poster.uid).child(key).child("like_count")
            
            likeCountRef.runTransactionBlock({ (mutableData) -> TransactionResult in
                
                let currentCount = mutableData.value as? Int ?? 0
                
                mutableData.value = currentCount + 1
                
                return TransactionResult.success(withValue: mutableData)
                
            }, andCompletionBlock: { (error, _, _) in
                
                if let error = error {
                    
                    assertionFailure(error.localizedDescription)
                    success(false)
                    
                } else {
                    
                    success(true)
                    
                }
            })
        
        }
        
    }
    
    static func delete(for post: Post, success: @escaping (Bool) -> Void) {
        
        guard let key = post.key else {
            return success(false)
        }
        
        let currentUID = User.current.uid
        
        let likesRef = Database.database().reference().child("postLikes").child(key).child(currentUID)
        
        likesRef.setValue(nil) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return success(false)
            }
            
            let likeCountRef = Database.database().reference().child("posts").child(post.poster.uid).child(key).child("like_count")
            
            likeCountRef.runTransactionBlock({ (mutableData) -> TransactionResult in
                
                let currentCount = mutableData.value as? Int ?? 0
                
                mutableData.value = currentCount - 1
                
                return TransactionResult.success(withValue: mutableData)
                
            }, andCompletionBlock: { (error, _, _) in
                
                if let error = error {
                    
                    assertionFailure(error.localizedDescription)
                    success(false)
                    
                } else {
                    
                    success(true)
                    
                }
            })
            
            
        }
        
    }
    
    // Check if a certain Post is liked by the current user
    static func isPostLiked(_ post: Post, byCurrentUserWithCompletion completion: @escaping (Bool) -> Void) {
        
        guard let postKey = post.key else {
            assertionFailure("Error: Post must have a key.")
            return completion(false)
        }
        
        let likesRef = Database.database().reference().child("postLikes").child(postKey)
        
        likesRef.queryEqual(toValue: nil, childKey: User.current.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let _ = snapshot.value as? [String : Bool] {
                completion(true)
            } else {
                completion(false)
            }
            
        })
        
    }
    
    //Convenience Method to quickly set a Post to be liked when tapping the Like Button
    static func setIsLiked(_ isLiked: Bool, for post: Post, success: @escaping (Bool) -> Void) {
        
        if isLiked {
            create(for: post, success: success)
        } else {
            delete(for: post, success: success)
        }
        
    }
    
}
