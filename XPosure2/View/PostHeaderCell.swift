//
//  PostHeaderCell.swift
//  XPosure2
//
//  Created by Henrik Wollersheim on 03.10.17.
//  Copyright © 2017 idek Ltd. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let height: CGFloat = 54
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var usernameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: - IBActions
    
    @IBAction func optionsButtonPressed(_ sender: Any) {
        print("Options Button Pressed")
    }
    

}
