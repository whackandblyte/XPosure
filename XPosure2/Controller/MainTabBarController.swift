//
//  MainTabBarController.swift
//  XPosure2
//
//  Created by Henrik Wollersheim on 25.09.17.
//  Copyright © 2017 idek Ltd. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //MARK: - Properties
    
    let photoHelper = XPPhotoHelper()
    
    
    //MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoHelper.completionHandler = { image in
            PostService.create(for: image)
        }

        delegate = self
        
        tabBar.unselectedItemTintColor = .black
    }

}

extension MainTabBarController: UITabBarControllerDelegate {
    
    //Checks to see if the tapped Bar Item is the one responsible for opening the photo capturing / importing dialog
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController.tabBarItem.tag == 1 {
            
            photoHelper.presentActionSheet(from: self)
            
            return false
            
        } else {
            
            return true
            
        }
    }
}
