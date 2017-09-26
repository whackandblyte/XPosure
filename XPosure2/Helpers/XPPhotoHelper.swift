//
//  XPPhotoHelper.swift
//  XPosure2
//
//  Created by Henrik Wollersheim on 25.09.17.
//  Copyright © 2017 idek Ltd. All rights reserved.
//

import UIKit

class XPPhotoHelper: NSObject {
    
    //MARK: - Properties
    
    var completionHandler: ((UIImage) -> Void)?
    
    //MARK: - Helper Methods
    
    //Presents an action sheet with the options to select an image from the device or, if the device has an inbuilt camera, to take a new photo.
    func presentActionSheet(from viewController: UIViewController) {
        
        let alertController = UIAlertController(title: "Take Photo", message: "Where do you want to get your photo from?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let capturePhotoAction = UIAlertAction(title: "Take photo", style: .default, handler: { (action) in
                self.presentImagePickerController(with: .camera, from: viewController)
            })
            
            alertController.addAction(capturePhotoAction)
            
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let uploadAction = UIAlertAction(title: "Upload from Library", style: .default, handler: { (action) in
                self.presentImagePickerController(with: .photoLibrary, from: viewController)
            })
            
            alertController.addAction(uploadAction)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        viewController.present(alertController, animated: true)
        
    }
    
    //Presents a UIImagePickerController (either activating the camera or showing the photo library, based on the sourceType taken as an input).
    func presentImagePickerController(with sourceType: UIImagePickerControllerSourceType, from viewController: UIViewController) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = sourceType
        
        imagePickerController.delegate = self
        
        viewController.present(imagePickerController, animated: true)
        
    }

}

extension XPPhotoHelper: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //Check if an image has been passed back, handle the image, and dismiss the Image Picker.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            completionHandler?(selectedImage)
            
        }
        
        picker.dismiss(animated: true)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
