//
//  GameViewController.swift
//  kennyGame
//
//  Created by Emrullah Yılmaz on 16.01.2019.
//  Copyright © 2019 Emrullah Yılmaz. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var keny1: UIImageView!
    @IBOutlet weak var keny2: UIImageView!
    @IBOutlet weak var keny3: UIImageView!
    @IBOutlet weak var keny4: UIImageView!
    @IBOutlet weak var keny5: UIImageView!
    @IBOutlet weak var keny6: UIImageView!
    @IBOutlet weak var keny7: UIImageView!
    @IBOutlet weak var keny8: UIImageView!
    @IBOutlet weak var keny9: UIImageView!
  
    
    var name = ""
    var score = 0
    
    var timer = Timer()
    var counter = 0
    var timerKenny = Timer()
    var kennyArray = [UIImageView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.textColor = UIColor.green
        scoreLabel.text = "Score : \(score)"
        userNameLabel.text = "Name : \(name)"
        
        let highScore = UserDefaults.standard.object(forKey: "highScore")
        if highScore == nil {
            highScoreLabel.text = "0"
        }
        if let newHigh = highScore as? Int{
            highScoreLabel.text = "\(newHigh)"
        }
        let highScoreName = UserDefaults.standard.object(forKey: "highScoreUser")
        if highScoreName == nil {
            highScoreLabel.text = "UserName"
        }
        if let newHighName = highScore as? String{
            highScoreLabel.text = newHighName
        }
        keny1.isUserInteractionEnabled = true
        keny2.isUserInteractionEnabled = true
        keny3.isUserInteractionEnabled = true
        keny4.isUserInteractionEnabled = true
        keny5.isUserInteractionEnabled = true
        keny6.isUserInteractionEnabled = true
        keny7.isUserInteractionEnabled = true
        keny8.isUserInteractionEnabled = true
        keny9.isUserInteractionEnabled = true

        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(GameViewController.increaseScoreDouble))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(GameViewController.increaseScoreDouble))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(GameViewController.increaseScoreDouble))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(GameViewController.increaseScoreDouble))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(GameViewController.increaseScoreDouble))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(GameViewController.increaseScoreDouble))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(GameViewController.increaseScoreDouble))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(GameViewController.increaseScoreDouble))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(GameViewController.increaseScoreDouble))
        
        keny1.addGestureRecognizer(gestureRecognizer1)
        keny2.addGestureRecognizer(gestureRecognizer2)
        keny3.addGestureRecognizer(gestureRecognizer3)
        keny4.addGestureRecognizer(gestureRecognizer4)
        keny5.addGestureRecognizer(gestureRecognizer5)
        keny6.addGestureRecognizer(gestureRecognizer6)
        keny7.addGestureRecognizer(gestureRecognizer7)
        keny8.addGestureRecognizer(gestureRecognizer8)
        keny9.addGestureRecognizer(gestureRecognizer9)
        
        // timer
        counter = 30
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.countDownTimer), userInfo: nil, repeats: true)
        timerKenny = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(GameViewController.hideKenny ), userInfo: nil, repeats: true)
        
        // array
        kennyArray.append(keny1)
        kennyArray.append(keny2)
        kennyArray.append(keny3)
        kennyArray.append(keny4)
        kennyArray.append(keny5)
        kennyArray.append(keny6)
        kennyArray.append(keny7)
        kennyArray.append(keny8)
        kennyArray.append(keny9)
        
        hideKenny()
        
    }
    
    @objc func hideKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1 )))
        kennyArray[random].isHidden = false
    }
    @objc func countDownTimer(){
        counter = counter - 1
        timeLabel.text = "\(counter)"
        if counter < 5 {
            timeLabel.textColor = UIColor.red
        }
        if counter == 0  {
            timer.invalidate()
            timerKenny.invalidate()
            
            if self.score > Int(highScoreLabel.text!)!{
                UserDefaults.standard.set(self.score, forKey: "highScore")
                UserDefaults.standard.set(self.name, forKey: "highScoreUser")
                self.highScoreLabel.text = "Personal High : \(score)"
                UserDefaults.standard.synchronize()
            }
            
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            let alert = UIAlertController(title: "TIME", message: "Time`s Up", preferredStyle: UIAlertController.Style.alert)
            let okBtn = UIAlertAction(title: "Ok ", style: UIAlertAction.Style.default, handler: nil)
            let replay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default, handler: {(UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 30
                self.timeLabel.text = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.countDownTimer), userInfo: nil, repeats: true)
                self.timerKenny = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(GameViewController.hideKenny ), userInfo: nil, repeats: true)
                
                
            })
            alert.addAction(replay)
            alert.addAction(okBtn)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    @objc func increaseScoreDouble(){
        score = score + 1
        scoreLabel.text = "Score : \(score)"
    }

    
}
