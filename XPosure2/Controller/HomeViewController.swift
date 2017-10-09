//
//  HomeViewController.swift
//  XPosure2
//
//  Created by Henrik Wollersheim on 24.09.17.
//  Copyright © 2017 idek Ltd. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Properties
    
    var posts = [Post]()
    
    // Create a new Date Formatter that converts a Posts timestamp into a String
    let timestampFormatter: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        return dateFormatter
        
    }()
    
    
    //MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        UserService.posts(for: User.current) { (posts) in
            self.posts = posts
            self.tableView.reloadData()
        }

    }
    
    //MARK: - Methods
    
    func configureTableView() {
        
        // Remove Separators for empty Cells
        tableView.tableFooterView = UIView()
        
        //Remove Separators from Cells
        tableView.separatorStyle = .none
        
    }

}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    // Each Post contains 3 rows: a Post Header, Image and Action Bar.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.section]

        switch indexPath.row {
            
        // Instantiate Post Header
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.PostElements.postHeaderCell) as! PostHeaderCell
            cell.usernameLabel.text = User.current.username
            
            return cell
            
            
        // Instantiate Post Image, use Kingfisher to load the image from Firebase Storage
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.PostElements.postImageCell) as! PostImageCell
            let imageURL = URL(string: post.imageURL)
            cell.postImageView.kf.setImage(with: imageURL)
            
            return cell
            
            
        // Instantiate Post Action Bar
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.PostElements.postActionCell) as! PostActionCell
            cell.delegate = self
            configureCell(cell, with: post)
            
            return cell
            
            
        default:
            fatalError("Error: unexpected indexPath.")
        }
        
    }
    
    func configureCell(_ cell: PostActionCell, with post: Post) {
        
        cell.timeStampLabel.text = timestampFormatter.string(from: post.creationDate)
        cell.likeButton.isSelected = post.isLiked
        cell.likeCounterLabel.text = "\(post.likeCount) likes"
        
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Return the correct height for the Header, Image and Post Action Bar
        switch indexPath.row {
        case 0:
            return PostHeaderCell.height
            
            
        case 1:
            let post = posts[indexPath.row]
            return post.imageHeight
            
            
        case 2:
            return PostActionCell.height
            
            
        default:
            fatalError()
        }
        
    }
    
}


extension HomeViewController: PostActionCellDelegate {
    
    func didPressLikeButton(_ likeButton: UIButton, on cell: PostActionCell) {
        
        guard let indexPath = tableView.indexPath(for: cell)
            else { return }
        
        likeButton.isUserInteractionEnabled = false
        
        let post = posts[indexPath.section]
        
        LikeService.setIsLiked(!post.isLiked, for: post) { (success) in
            
            defer {
                likeButton.isUserInteractionEnabled = true
            }
            
            guard success else { return }
            
            post.likeCount += !post.isLiked ? 1 : -1
            post.isLiked = !post.isLiked
            
            guard let cell = self.tableView.cellForRow(at: indexPath) as? PostActionCell
                else { return }
            
            DispatchQueue.main.async {
                self.configureCell(cell, with: post)
            }
            
        }
        
    }
    
}
