//
//  Storyboard+Utility.swift
//  XPosure2
//
//  Created by Henrik Wollersheim on 23.09.17.
//  Copyright © 2017 idek Ltd. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    enum XPType: String {
        case main
        case login
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(type: XPType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initialViewController(for type: XPType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }
        
        return initialViewController
    }
}
