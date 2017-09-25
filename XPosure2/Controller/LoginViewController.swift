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
        loginButton.layer.cornerRadius = 8
        
    }
    
    //MARK: - IBActions
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        //Call FirebaseAuthUI to present the default Firebase Login VC
        
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
        
        UserService.show(forUID: user.uid) { (user) in
            if let user = user {
                
                User.setCurrent(user, writeToUserDefaults: true)
                
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
                
            } else {
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        }

    }
    
}
