//
//  PostActionCell.swift
//  XPosure2
//
//  Created by Henrik Wollersheim on 04.10.17.
//  Copyright © 2017 idek Ltd. All rights reserved.
//

import UIKit

protocol PostActionCellDelegate: class {
    func didPressLikeButton(_ likeButton: UIButton, on cell: PostActionCell)
}


class PostActionCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let height: CGFloat = 46
    
    weak var delegate: PostActionCellDelegate?
    

    //MARK: - IBOutlets
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCounterLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    
    //MARK: - VC Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    //MARK: - IBActions
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        delegate?.didPressLikeButton(sender as! UIButton, on: self)
    }
    

}
