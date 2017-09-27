//
//  StorageReference+Post.swift
//  XPosure2
//
//  Created by Henrik Wollersheim on 27.09.17.
//  Copyright © 2017 idek Ltd. All rights reserved.
//

import Foundation
import FirebaseStorage

extension StorageReference {
    
    static let dateFormatter = ISO8601DateFormatter()
    
    static func newPostImageReference() -> StorageReference {
        
        let uid = User.current.uid
        let timestamp = dateFormatter.string(from: Date())
        
        return Storage.storage().reference().child("images/posts/\(uid)/\(timestamp).jpg")
        
    }
    
}
