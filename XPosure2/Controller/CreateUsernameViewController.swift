//
//  CreateUsernameViewController.swift
//  XPosure2
//
//  Created by Henrik Wollersheim on 19.09.17.
//  Copyright © 2017 idek Ltd. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
    
    //MARK: - Subviews
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 8
        
    }

    //MARK: - IBActions
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else { return }
            
            User.setCurrent(user)
            
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            
            if let initialViewController = storyboard.instantiateInitialViewController() {
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}
