//
//  MainVC.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 01/12/2016.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import UIKit
import CoreGraphics

class MainVC: UIViewController {
    
    var categorieVC: CategoriesVC!

    @IBOutlet weak var vieww: LoadingCircle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func startSinglePlayerGame() {
        categorieVC = CategoriesVC()
        performSegue(withIdentifier: "toCategories", sender: nil)
//        present(categorieVC, animated: true, completion: nil)
    }

}
