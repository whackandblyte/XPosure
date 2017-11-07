//
//  FindFriendsCell.swift
//  XPosure2
//
//  Created by Henrik Wollersheim on 11.10.17.
//  Copyright © 2017 idek Ltd. All rights reserved.
//

import UIKit

protocol FindFriendsCellDelegate: class {
    func didPressFollowButton(_ followButton: UIButton, on cell: FindFriendsCell)
}


class FindFriendsCell: UITableViewCell {
    
    //MARK: - Delegate
    
    weak var delegate: FindFriendsCellDelegate!
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    //MARK: - Cell Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    //MARK: - IBActions
    
    @IBAction func followButtonPressed(_ sender: Any) {
        delegate?.didPressFollowButton(sender as! UIButton, on: self)
    }
    
    
}
