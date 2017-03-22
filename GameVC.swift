//
//  GameVC.swift
//  Lettercheck
//
//  Created by Tobias Gozzi on 10/01/2017.
//  Copyright © 2017 Tobias Gozzi. All rights reserved.
//

import UIKit

class GameVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let downloadedWord = "RELEVATION"
    var word = ""
    var timer : Timer? = nil
    var countBack: TimeInterval = 45
    var timerLoop: RunLoop = RunLoop()
    let possiblePoint = 1200
    var effectivePoints: Int?
    var diminisher : Int!
    
    var resultVC : ResultsVC!
    
    var possibilities : Int {
        get {
            if (downloadedWord.characters.count > 4) {
                return downloadedWord.characters.count / 3 * 2
            } else {
                return downloadedWord.characters.count
            }
        }
    }
    
    //increments with every wrong input, if reaches count of possibilities game is over
    var error: Int = 0 {
        didSet {
            if (error >= possibilities) {
                gameOver()
            } else {
                print("everything ok, but don't keep pressing the wrong buttons")
            }
        }
    }
    
    
    @IBOutlet weak var letterCollection: UICollectionView!
    @IBOutlet weak var time: SimpleLabel!
    @IBOutlet weak var pointsLbl: SimpleLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var count = 0
        diminisher = possiblePoint / (possibilities + Int(countBack))
        effectivePoints = possiblePoint
        pointsLbl.text = "\(effectivePoints!)"
        
        while (count < downloadedWord.characters.count) {
            word.append("_")
            
            count += 1
        }
        
       // let screen = UIScreen.main.bounds
        
       // let width = screen.width
        
        //letterCollection.addConstraint(NSLayoutConstraint(item: letterCollection, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 1))

        letterCollection.delegate = self
        letterCollection.dataSource = self
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        //timer = Timer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timerLoop.add(timer!, forMode: .defaultRunLoopMode)
        timerLoop.run()
    }

    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return downloadedWord.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       // print("starting to build cell")
        if let cell = letterCollection.dequeueReusableCell(withReuseIdentifier: "letterCell", for: indexPath) as? LetterCell {
            
            let nsWord = NSString(string: word)
            
            let unicharString = Character(UnicodeScalar(nsWord.character(at: indexPath.row))!)
            print("lettercell created")

            cell.hiddenCharacter = unicharString

            cell.configureCell()
            
            
            return cell
        } else {
            print("dequenont")
        }
        
        return LetterCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func updateWord(word: String, index: Int, char: Character) -> String {
        var arr = Array(word.characters)
        var replacedWord = ""
        
        
        arr[index] = char
        
        for item in arr {
            replacedWord.append(item)
        }
        
        return replacedWord
    }
    
    
    
    func gameOver() {
        print("game is over")
    
        performSegue(withIdentifier: "GameResult", sender: nil)
        
        //        self.presentingViewController?.dismiss(animated: true, completion: nil)
//        navigationController?.popViewController(animated: true)

        
       // present(resultVC, animated: true, completion: nil)
      
        
    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameResult" {
            if let destVC = segue.destination as? ResultsVC {
                destVC.score = effectivePoints
            }
        }
    }


    
    func incrementError() {
        error += 1
    }
    
    func gameWon() {
        print("game won")
    }
    
    func updateTimer() {
        
        var formattedTime : String = ""
        
        let minutes = countBack / 60
        let seconds = countBack.truncatingRemainder(dividingBy: 60)
        
        if countBack >= 0 {
            if countBack > 59 {
                formattedTime.append("\(Int(minutes))")
            } else {
                formattedTime.append("0")
            }
            if seconds > 9 {
                formattedTime.append(":\(Int(seconds))")
            } else {
                formattedTime.append(":0\(Int(seconds))")
            }

        } else {
            formattedTime.append("Time's up")
            timer?.invalidate()
            
        }
        
        updatePoints()
        
        //testing timer and run loop with ternary conditional operator
        time.text = formattedTime
        countBack -= 1
    }
    
    @IBAction func checkLetter(sender: UIButton) {
        if let pressedBtn = sender.titleLabel?.text {
            if downloadedWord.contains(pressedBtn) {
                var count = 0
                while (count < downloadedWord.characters.count) {
                    
                    let index = downloadedWord.index(downloadedWord.startIndex, offsetBy: count)
                    if(pressedBtn == String(downloadedWord[index])) {
                        
                        let newWord = word
                        
                        word = updateWord(word: newWord, index: count, char: pressedBtn.characters.first!)
                        
                        
                    }
                    
                    count += 1
                }
                letterCollection.reloadData()
                
                if !(word.contains("_")) {
                    gameWon()
                }
                
            } else {
                print("no character found")
                incrementError()
                updatePoints()
            }
            
        } else {
            print("no content in button")
        }
    }
    
    func updatePoints() {
        effectivePoints! -= diminisher
        
        if effectivePoints! < 0 {
            effectivePoints = 0
        }
        pointsLbl.text = "\(effectivePoints!)"
        
        print("diminisher: \(diminisher) effective points: \(effectivePoints!) possibilities: \(possibilities) possible points: \(possiblePoint)")
    }
    
    
    
    deinit {
        print("deint view")
        timer = nil
        timerLoop.run(until: Date())
        
    }

}
