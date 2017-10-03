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
    
    //MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell", for: indexPath) as! PostImageCell
        
        let imageURL = URL(string: post.imageURL)
        cell.postImageView.kf.setImage(with: imageURL)
        
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = posts[indexPath.row]
        
        return post.imageHeight
    }
    
}
