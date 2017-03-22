//
//  Constants.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 28/11/2016.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseDatabase


class DataService {
    
    static let ds = DataService()
    
    let FIRPATH: FIRDatabaseReference =  FIRDatabase.database().reference()
    let FIRUSERS: FIRDatabaseReference = FIRDatabase.database().reference().child("USERS")

    //category paths
    
    let CATEGORIES: FIRDatabaseReference = FIRDatabase.database().reference().child("categories")
    
    
    var CURRENT_USER: FIRDatabaseReference {
        let data = UserDefaults.standard.value(forKey: KEY_UID) as! String
        let user = FIRUSERS.child(data)
        
        return user
    }
    
    func createUser(_ userID: String, from provider: String) {
        FIRUSERS.child(userID).setValue(["provider" : provider])
    }
    
}
