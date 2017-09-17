//
//  LoginViewController.swift
//  XPosure2
//
//  Created by Franziska Reuter on 17.09.17.
//  Copyright © 2017 idek Ltd. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - IBActions
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        print("Login Button Pressed.")
    }
    

}
