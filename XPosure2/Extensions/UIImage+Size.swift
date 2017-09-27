//
//  UIImage+Size.swift
//  XPosure2
//
//  Created by Henrik Wollersheim on 27.09.17.
//  Copyright © 2017 idek Ltd. All rights reserved.
//

import UIKit

extension UIImage {
    var aspectHeight: CGFloat {
        let heightRatio = size.height / 736
        let widthRatio = size.width / 414
        let aspectRatio = fmax(heightRatio, widthRatio)
        
        return size.height / aspectRatio
    }
}
