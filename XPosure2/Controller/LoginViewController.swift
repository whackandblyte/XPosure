//
//  LoginViewController.swift
//  XPosure2
//
//  Created by Henrik Wollersheim on 17.09.17.
//  Copyright © 2017 idek Ltd. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - IBActions
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        authUI.delegate = self
        
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
        
    }

}

extension LoginViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        
        guard let user = user
            else { return }
        
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let user = User(snapshot: snapshot) {
                print("Welcome back, \(user.username)!")
            } else {
                print("New user!")
            }
        })
    }
    
}