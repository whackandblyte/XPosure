//
//  StorageService.swift
//  XPosure2
//
//  Created by Henrik Wollersheim on 26.09.17.
//  Copyright © 2017 idek Ltd. All rights reserved.
//

import UIKit
import FirebaseStorage

struct StorageService {
    
    //MARK: - Methods
    
    //Convert an image to Data Datatype, compress it, upload it to a reference path as provided as an input, and return the images URL.
    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.1) else {
            return completion (nil)
        }
        
        reference.putData(imageData, metadata: nil) { (metadata, error) in
            
            if let error = error {
                
                assertionFailure(error.localizedDescription)
                return completion(nil)
                
            }
            
            completion(metadata?.downloadURL())
            
        }
        
    }
    
}
