//
//  ViewController.swift
//  Catcher
//
//  Created by Test on 30.10.23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var grogu1: UIImageView!
    @IBOutlet weak var grogu2: UIImageView!
    @IBOutlet weak var grogu3: UIImageView!
    @IBOutlet weak var grogu4: UIImageView!
    @IBOutlet weak var grogu5: UIImageView!
    @IBOutlet weak var grogu6: UIImageView!
    @IBOutlet weak var grogu7: UIImageView!
    @IBOutlet weak var grogu8: UIImageView!
    @IBOutlet weak var grogu9: UIImageView!
    
    var timer = Timer()
    var score = 0
    var counter = 0
    var hideTimer = Timer()
    var highScore = 0
    var groguArray = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighscore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighscore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        grogu1.isUserInteractionEnabled = true
        grogu2.isUserInteractionEnabled = true
        grogu3.isUserInteractionEnabled = true
        grogu4.isUserInteractionEnabled = true
        grogu5.isUserInteractionEnabled = true
        grogu6.isUserInteractionEnabled = true
        grogu7.isUserInteractionEnabled = true
        grogu8.isUserInteractionEnabled = true
        grogu9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        grogu1.addGestureRecognizer(recognizer1)
        grogu2.addGestureRecognizer(recognizer2)
        grogu3.addGestureRecognizer(recognizer3)
        grogu4.addGestureRecognizer(recognizer4)
        grogu5.addGestureRecognizer(recognizer5)
        grogu6.addGestureRecognizer(recognizer6)
        grogu7.addGestureRecognizer(recognizer7)
        grogu8.addGestureRecognizer(recognizer8)
        grogu9.addGestureRecognizer(recognizer9)
        
        groguArray = [grogu1, grogu2, grogu3, grogu4, grogu5, grogu6, grogu7, grogu8, grogu9]
        
        hideGrogu()
    }
    
    func runTimer() {
        counter = 10
        timerLabel.text = "Time: \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideGrogu), userInfo: nil, repeats: true)
    }
    
    @objc func hideGrogu() {
        for grogu in groguArray {
            grogu.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(groguArray.count - 1)))
        groguArray[random].isHidden = false
    }
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func timerFunction() {
        timerLabel.text = "Time: \(counter)"
        counter -= 1
        
        if counter < 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for grogu in groguArray {
                grogu.isHidden = true
            }
            
            if self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            let alert = UIAlertController(title: "Time is Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {
                (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timerLabel.text = "Time: \(self.counter)"
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func startButton(_ sender: Any) {
        runTimer()
    }
    
}

