//
//  ScrabbleCommunicator.swift
//  BallerScrabble
//
//  Created by Kayser, Zack (NonEmp) on 1/12/18.
//  Copyright © 2018 Kayser, Zack (NonEmp). All rights reserved.
//

import Foundation

class ScrabbleCommunicator {
    static func getScrabble(word: String, completionHandler: @escaping (Scrabble?, Error?) -> Scrabble?) {
        let endpoint = Scrabble.getScoreUrl(word: word)
        guard let url = URL(string: endpoint) else {
            print("Error: URL creation failed")
            let error = BackendError.urlError(reason: "Failed to construct URL")
            completionHandler(nil, error)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            
            guard let responseData = data else {
                print("Error: Failed to receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let scrabble = try decoder.decode(Scrabble.self, from: responseData)
                completionHandler(scrabble, nil)
            } catch {
                print("Error converting scrabble from JSON")
                let error = BackendError.objectSerialization(reason: "Failed to convert JSON to Scrabble")
                completionHandler(nil, error)
            }
        })
        task.resume()
    }

}
