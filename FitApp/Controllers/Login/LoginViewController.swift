//
//  LoginViewController.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/26/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase
//import FirebaseFacebookAuthUI
import GoogleSignIn

typealias FIRUser = FirebaseAuth.User
// let user: FIRUser? = Auth.auth().currentUser //Singleton

class LoginViewController: UIViewController {
    
    @IBOutlet var loginButton: UIButton!
    
    
    override func viewDidLoad() {

    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        
        authUI.delegate = self
        
        // configure Auth UI for Facebook and Google login
        let providers: [FUIAuthProvider] = [FUIGoogleAuth(), FUIFacebookAuth()]
        authUI.providers = providers
        
        
        let authViewController = authUI.authViewController()
        
        let screenSize: CGRect = UIScreen.main.bounds
        let myView = UIImageView(image: UIImage(named: "LoginPhoto")!)
        myView.contentMode = .scaleAspectFit
        myView.frame = CGRect(x: 0, y: screenSize.height*0.17, width: screenSize.width , height: screenSize.height*0.4)
        authViewController.view.addSubview(myView)
        
        present(authViewController, animated: true)
    }
    
}

extension LoginViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        //Error handling
        if let error = error {
//            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        
        guard let user = authDataResult?.user
            else { return }
        
        //Designating Reference
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        //Reading Firebase
        // https://stackoverflow.com/questions/37403747/firebase-permission-denied
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            //Handle New User
            if let user = User(snapshot: snapshot) { //  retrieve user data from snapshot
                User.setCurrent(user, writeToUserDefaults: true)

                //Instantiating root view controller
                let storyboard = UIStoryboard(name: "Tabbar", bundle: .main)
                if let initialViewController = storyboard.instantiateInitialViewController() {
                    self.view.window?.rootViewController = initialViewController
                    self.view.window?.makeKeyAndVisible()
                }

            } else {
                
                //Handle Existing User
                self.performSegue(withIdentifier: "toCreateUsername", sender: self)

            }
        })
        
    }
}
