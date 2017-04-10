//
//  File.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 03/04/2017.
//  Copyright © 2017 Tobias Gozzi. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import CoreData

class CheckForUpdatesVC: UIViewController {
    
    var categories: [LCCategory] = []
    var words: [WordToGuess]!
    var hints: [Hints]!
    
    //test data, should be implemented as global static
    let languageIndex = 0
    
    
    var isUpdateAvailable: Bool = false {
        didSet {
            print("value was updated to \(isUpdateAvailable))")
            fetchGameData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkDBVersion()
    }
    
    func checkDBVersion() {
        
        let version = DataService.ds.DB_VERSION_DATA
        
        let queue = DispatchQueue(label: "queue")
        
        queue.sync {
            
            version.observeSingleEvent(of: .value) { (data, error) in
                
                if error == nil {
                    
                    //Dummy data for testing
                    let dummyVersion: Float = 0.1
                    
                    if let versionData = data.value as? Float {
                        if versionData > dummyVersion {
                            self.isUpdateAvailable = true
                        }
                    }
                    
                    
                } else {
                    
                    print("error retrieving DB version")
                    
                }
            }
            
        }
        
    }
    
    
    
    func fetchGameData() {
        
        
        
        //if online DB version is newer than device DB version, logic will download new game data
        if isUpdateAvailable {

            let categoriesData = DataService.ds.CATEGORIES
            let wordsData = DataService.ds.WORDS
            let hintsData = DataService.ds.HINTS
            
            
            categoriesData.observeSingleEvent(of: .value) {
                (snapshot: FIRDataSnapshot) in
                
                guard let snapData = snapshot.value as? Dictionary<String,[String]> else {
                    print("no category")
                    return
                }
                
                
                self.categories = snapData.map({ (key,val) -> LCCategory in
                    
                    let currentCategory = LCCategory(withNames: val, id: key)
                    
                    return currentCategory
                })

                print(self.categories.count)
                
            }
            
            wordsData.observeSingleEvent(of: .value, with: { (data: FIRDataSnapshot) in
                
                if let snapData = data.value as? Dictionary<String,[[String]]> {

                    
                    
                    for item in snapData {
                        
                        
                        self.words = []
                        for translations in item.value {
                            
                            self.words.append(WordToGuess(words: translations, withId: translations[0], from: item.key))
                            
                            for singleWord in translations {
                                print(singleWord)
                            }
                        }

                    }
                    
                } else { print("snap data could not be accessed")}
                
                
            })
            
            hintsData.observeSingleEvent(of: .value, with: { (data: FIRDataSnapshot) in
                if let snapdata = data.value as? Dictionary<String,Any> {
                    
                    
                    for catItem in snapdata {
                        print(catItem.key)
                        
                        if let hintsCategoryDict = catItem.value as? Dictionary<String,Any> {
    
                            for forWord in hintsCategoryDict {
                             
                                if let hintsArray = forWord.value as? [[String]] {
                                    self.hints = []
                                    for currentHintMultilang in hintsArray {

                                        let h = Hints(word: forWord.key, hints: [currentHintMultilang], category: catItem.key)
                                        self.hints.append(h)
                                        print("hints: \(h.forWordId) \(h.hintsMulitlang) \(h.fromCategory)", separator: "-", terminator: "\n")
                                    }
                                    
                                } else {print("no hintsarray found")}
                                

                            }
                            
    
                        } else {print("no hintsCategoryDict")}

                    }
                    
                } else  {print("no snaoData")}
            })
            
            
        } else {
            print("Update is available: \(isUpdateAvailable)")
        }
        
    }
    

    
}
