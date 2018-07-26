//
//  UserService.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/26/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//


import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct UserService {
    
    // insert user-related networking code here

    
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
        
        let userAttrs = ["username": username]
        
        let ref = Database.database().reference().child("users").child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in //Setting Value
            
            //Error handling
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            //Reading Database
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
}
