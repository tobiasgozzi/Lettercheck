//
//  LoginVC.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 21/11/2016.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit


class LoginVC: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: MainButton!
    
    
    var mainVC: MainVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadLoginData()
    }
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        mainVC = MainVC()
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        mainVC = MainVC()
//        super.init(coder: aDecoder)
//    }
    
    @IBAction func emailSignIn(){
        if let user = username.text, let pwd = password.text, user != "" && pwd != "" {
            
            FIRAuth.auth()?.createUser(withEmail: user, password: pwd, completion: { (firebaseUser, error) in
                if firebaseUser != nil {
                    
                    if let id = firebaseUser?.uid {
                        print("user created with id: \(id)")
                    }
                    
                } else {
                    
                    FIRAuth.auth()?.signIn(withEmail: user, password: pwd, completion: { (loginUser, err) in
                        
                        if loginUser != nil {
                            
                            print("user signed in with id \(loginUser?.uid)")
                            
                            
                            self.saveLoginData(uid: (loginUser?.uid)!)
                            
                            self.performSegue(withIdentifier: "toMain", sender: nil)
                            
                        } else if err != nil {
                            if let errCode = err?._code {
                                
                                switch errCode {
                                case 17009:
                                    self.createAlertMsg(withTitle: "Password wrong", message: "The password you have entered is wrong.", errorCode: errCode)
                                    break
                                case 17010:
                                    self.createAlertMsg(withTitle: "Server is busy", message: "It seems the server is busy. Give him some slack and try again in some seconds.", errorCode: errCode)
                                    break
                                default:
                                    print(errCode)
                                    break
                                  
                                    
                                }

                            }
                        }
                        
                    })
                }
                
            })

        } else {
            //handle wrong input
        }
        
    }
    
    @IBAction func fblogin() {
        let login = FBSDKLoginManager()
        
        login.logIn(withReadPermissions: [ "email" ], from: self) {
            loginResult, err in
            

            if err == nil {
                print("facebook login \(loginResult)")
                
                let fbCredentials = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                
                FIRAuth.auth()?.signIn(with: fbCredentials, completion: { (fbUser, fbAuthErr) in
                    
                    if fbAuthErr == nil {

                        if let signedUser = fbUser {
                            if let userData = signedUser.providerData.first {
                                self.createPlayerID(id: userData.uid, from: userData.providerID)
                                self.saveLoginData(uid: userData.uid)
                            }
                            self.performSegue(withIdentifier: "toMain", sender: nil)
                        }
                        
                    }
                    
                })
            } else {
                print(err.debugDescription)
            }

            
        }
        
    }
    
    func createPlayerID(id : String, from provider: String) {
        let userID = String(Date().timeIntervalSince1970)
        
        Player(user: userID, withID: id , highscore: 0, gamesWithoutError: 4)
        
        UserDefaults.standard.setValue(id, forKey: KEY_UID)
        
        DataService.ds.createUser(id, from: provider)
        
        print(UserDefaults.standard.value(forKey: KEY_UID) as! String)
    }
    
    func createAlertMsg(withTitle: String, message: String, errorCode: Int?) {
        
        let alert = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        if let code = errorCode {
            
            switch code {
            case 17009:
                alert.addAction(UIAlertAction(title: "Request new password", style: .default, handler: nil))
                break
            default: break
                
            }
        }
        
        self.present(alert, animated: true, completion: nil)
    }

    
    //for building purpose
    deinit {
        print("view deinitialized")
    }
    
    
    
    
    
    
    func saveLoginData(uid: String) {

        UserDefaults.standard.setValue(username, forKey: "uid")
    }
    
    func loadLoginData(){
        
        if let userCredential = UserDefaults.standard.value(forKey: "uid") as? String {
            performSegue(withIdentifier: "toMain", sender: nil)

        }
        
    }
    
}


    

