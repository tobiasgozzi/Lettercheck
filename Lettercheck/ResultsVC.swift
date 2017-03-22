//
//  ResultsVC.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 08/02/2017.
//  Copyright © 2017 Tobias Gozzi. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase


class ResultsVC: UIViewController {
    
    //points from just finished game
    var score: Int!
    //helps to exit progressbar loop after synched
    var synching = true
    //summed points of player, will be updated from database
    var points = 0

    var run : RunLoop = RunLoop()
    var timer : Timer!
    
    
    @IBOutlet weak var scoreLbl: SimpleLabel!
    @IBOutlet weak var circelProgress: LoadingCircle!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLbl.text = "\(score!)"


//        let queue = DispatchQueue(label: "cirlce")
        
//        queue.async {
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        timer = Timer.scheduledTimer(timeInterval: 0.002, target: self, selector: #selector(progressCircle), userInfo: nil, repeats: true)
//        if run == nil {
//            print("run nil")
//        } else if timer == nil {
//            print("timer nil")
//        }
        run.add(timer!, forMode: .defaultRunLoopMode)
        run.run()
        
        
        self.synching = self.saveProgress()
        
//        var count = 0
//        let queue = DispatchQueue(label: "que")
        
//        queue.async {
//            while(self.synching) {
//                
        
//                DispatchQueue.main.async {
//                    count += 1
//                    if (count % 800 == 0) {
//                        self.circelProgress.rot()
//                        print(count)
//                    }
//                }
//            }
//        }
        
    }
    
    func saveProgress() -> Bool {
        let data = DataService.ds.CURRENT_USER.observeSingleEvent(of: FIRDataEventType.value , with: { (snapshot) in
            let snaps = snapshot.value as? [String: Any] ?? [:]
            if let oldPoints = snaps[TROPHYPOINTS] as? Int {
                self.points = oldPoints
                self.points += self.score
                print(self.points)
                DataService.ds.CURRENT_USER.setValue([TROPHYPOINTS:self.points])
                self.timer.invalidate()
            }
            
        })

        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func progressCircle() {

        DispatchQueue.main.async {
                self.circelProgress.rot()
        }
    }
    
    @IBAction func selectedAction(sender: MainButton) {
        print(sender.titleLabel?.text! ?? "no title")
    }

}
