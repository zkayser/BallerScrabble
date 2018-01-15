//
//  ViewController.swift
//  BallerScrabble
//
//  Created by Kayser, Zack (NonEmp) on 1/10/18.
//  Copyright © 2018 Kayser, Zack (NonEmp). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var scrabble = Scrabble(word: "", score: 0)
    let jsonErrorMsg = "Error parsing JSON. Sorry :/"
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getScrabble(word: scrabble.word)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getScrabble(word: String) {
        guard let url = URL(string: Scrabble.getScoreUrl(word: word)) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, err) in
            if let data = data {
                do {
                    self.scrabble = try JSONDecoder().decode(Scrabble.self, from: data)
                    DispatchQueue.main.async {
                        if let message = self.scrabble.message {
                            self.messageLabel.text = message
                        }
                        self.scoreLabel.text = "\(self.scrabble.score)"
                    }
                    print("Scrabble = \(self.scrabble)")
                } catch {
                    print(self.jsonErrorMsg)
                }
            } else {
                print(self.jsonErrorMsg)
            }
        }.resume()
    }

    @IBAction func updateWord(_ sender: UITextField) {
        if let word = sender.text {
            self.scrabble = Scrabble(word: word, score: 0)
        } else {
            print("Error updating word.")
            return
        }
    }
    
    @IBAction func checkBallerness(_ sender: UIButton) {
        getScrabble(word: self.scrabble.word)
    }
}

