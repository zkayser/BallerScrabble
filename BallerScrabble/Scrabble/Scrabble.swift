//
//  Scrabble.swift
//  BallerScrabble
//
//  Created by Kayser, Zack (NonEmp) on 1/12/18.
//  Copyright © 2018 Kayser, Zack (NonEmp). All rights reserved.
//

import Foundation

struct Scrabble: Codable {
    let word: String
    let score: Int
    var message: String? {
        get {
            switch score {
                case let num where num == 0:
                    return "Ballers are made, not born.\nDo you have what it takes?"
                case let num where num < 10:
                    return "Your scrabble-foo lacks ballerness.\nTry again."
                case let num where num >= 10 && num < 20:
                    return "You have potential.\nBut potential does not a baller make.\n -- Socrates"
                case let num where num >= 20:
                    return "Congratulations.\nYou are well-versed in the art of ballerness."
                default:
                    return "Totally not baller"
            }
        }
    }
    
    init(word: String, score: Int) {
        self.word = word
        self.score = score
    }
    
    static func getScoreUrl(word: String) -> String {
        return "http://172.20.10.5:8080/getScore?word=\(word)"
    }
    
}
