//
//  CategoriesVC.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 12/12/2016.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import UIKit
import FirebaseDatabase


class CategoriesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var categorieTable: UITableView!

    var game: GameVC!
    
    var selectedCategory: String!
    
    var nrOfCategories: Int?
    var categories: [String]? {
        didSet {
            nrOfCategories = categories?.count
            print("\(categories?.count)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categorieTable.delegate = self
        categorieTable.dataSource = self
        categorieTable.isUserInteractionEnabled = false

        let queue = DispatchQueue(label: "ui")
        
        queue.async {
            self.fetchCategories()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return (nrOfCategories != nil) ? nrOfCategories! : 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = categorieTable.dequeueReusableCell(withIdentifier: "Category", for: indexPath) as? CategoriesTableViewCell {
            if categories != nil && (categories?.count)! > 0 {
                cell.configureCell(name: categories![indexPath.row])
            }
            
            //cell.target(forAction: Selector(("cellSelected:")), withSender: nil)

            return cell
            
        }
        return CategoriesTableViewCell()

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = categories![indexPath.row]
        print(categories![indexPath.row])
        game = GameVC()
        performSegue(withIdentifier: "startGame", sender: nil)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "starGame" {
            game.word = ""
        }
    }
    
    
//    override func performSegue(withIdentifier identifier: String, sender: Any?) {
//        if identifier == "startGame" {
//            
//            //present(game, animated: true, completion: nil)
//        }
//    }
    
    
    //is deprecated with new "offline" logic, fetch data from device 
    func fetchCategories() {
        let content = DataService.ds.CATEGORIES
        
        content.observeSingleEvent(of: .value) {
            (snapshot: FIRDataSnapshot) in
            
            guard let snapData = snapshot.value as? Dictionary<String,Bool> else {
                return
            }
            self.categories = snapData.map({ (key, val) -> String in
                print(key)
                return key
            })
           // self.nrOfCategories = sel.count

            DispatchQueue.main.async {
                self.categorieTable.reloadData()
                
                self.categorieTable.isUserInteractionEnabled = true
            }
        }

        
    }

    

    
    func cellSelected(){
        print("cell selected")
    }
    
    
}
