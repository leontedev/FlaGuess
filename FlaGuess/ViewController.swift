//
//  ViewController.swift
//  FlaGuess
//
//  Created by Mihai Leonte on 8/26/19.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var round = 0
    var highScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        highScore = defaults.integer(forKey: "highscore")
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: showRound)
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
//    @objc func showRound() {
//        let ac = uialert
//    }
    
    func askQuestion(alert: UIAlertAction! = nil) {
        round += 1
        
        if round > 10 {
            title = "Final Score: \(score) "
            
            var message = ""
            if score > highScore {
                message = "Your new high score is \(score)"
                let defaults = UserDefaults.standard
                defaults.set(score, forKey: "highscore")
            } else {
                message = "Your final score is \(score)"
            }
            
            let ac = UIAlertController(title: "Game Over", message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true, completion: nil)
            
            button1.isHidden = true
            button2.isHidden = true
            button3.isHidden = true
            
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            
            button1.setImage(UIImage(named: countries[0]), for: .normal)
            button2.setImage(UIImage(named: countries[1]), for: .normal)
            button3.setImage(UIImage(named: countries[2]), for: .normal)
            
            title = "\(countries[correctAnswer].uppercased())? Score: \(score) "
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        print("sender.tag is \(sender.tag)")
        print("correctAnswer is \(correctAnswer)")
        
        if sender.tag == correctAnswer {
            score += 1
            
            title = "Correct"
            message = "Your new score is \(score)"
        } else {
            score -= 1
            
            title = "Wrong"
            message = "That’s actually the flag of \(countries[sender.tag].uppercased()). Your new score is \(score)"
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        
        // Day 58 Challenge - make the flags scale down with a little bounce when pressed.
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            let scaleDown = CGAffineTransform(scaleX: 0.8, y: 0.8)
            sender.transform = scaleDown
        }) { [weak self] (_) in
            sender.transform = .identity
            self?.present(ac, animated: true, completion: nil)
        }
        
//        UIView.animate(withDuration: 1, animations: {
//            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//
//        }) { (_) in
//            present(ac, animated: true, completion: nil)
//        }
        
    }
    


}

