//
//  FollowService.swift
//  XPosure2
//
//  Created by Henrik Wollersheim on 11.10.17.
//  Copyright © 2017 idek Ltd. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct FollowService {
    
    private static func followUser(_ user: User, forCurrentUserWithSuccess success: @escaping (Bool) -> Void) {
        
        let currentUID = User.current.uid
        let followData = ["followers/\(user.uid)/\(currentUID)" : true, "following/\(currentUID)/\(user.uid)" : true]
        
        let ref = Database.database().reference()
        ref.updateChildValues(followData) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
            
            success(error == nil)
        }
        
    }
    
    private static func unFollowUser(_ user: User, forCurrentUserWithSuccess success: @escaping (Bool) -> Void) {
        
        let currentUID = User.current.uid
        let followData = ["followers/\(user.uid)/\(currentUID)" : NSNull(), "following/\(currentUID)/\(user.uid)" : NSNull()]
        
        let ref = Database.database().reference()
        ref.updateChildValues(followData) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
            
            success(error == nil)
        }
        
    }
    
    //Public Setter method for following / unfollowing a user, depending on whether isFollowing is set to true or false.
    static func setIsFollowing(_ isFollowing: Bool, fromCurrentUserTo followee: User, success: @escaping (Bool) -> Void) {
        
        if isFollowing {
            followUser(followee, forCurrentUserWithSuccess: success)
        } else {
            unFollowUser(followee, forCurrentUserWithSuccess: success)
        }
        
    }
    
    
    //Public Getter to determine whether or not a specific user is following the current user.
    static func isUserFollowed(_ user: User, byCurrentUserWithCompletion completion: @escaping (Bool) -> Void) {
        
        let currentUID = User.current.uid
        let ref = Database.database().reference().child("followers").child(user.uid)
        
        ref.queryEqual(toValue: nil, childKey: currentUID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? [String : Bool] {
                completion(true)
            } else {
                completion(false)
            }
        })
        
    }
    
    
    
}
