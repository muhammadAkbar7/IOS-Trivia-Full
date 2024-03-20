//
//  FetchTrivia.swift
//  Trivia
//
//  Created by Muhammad Akbar on 3/19/24.
//

import Foundation

class FetchTrivia {
    static func fetchTriviaGen(completion: (([TriviaQuestion]) -> Void)? = nil) {
//        let parameters =
        let url = URL(string: "https://opentdb.com/api.php?amount=10")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // this closure is fired when the response is received
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
            }
            guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
            }
            let decoder = JSONDecoder()
            let response = try! decoder.decode(TriviaAPIResponse.self, from: data)
            DispatchQueue.main.async {
                completion?(response.triviaQuestion)
            }
        }
        task.resume()
    }
}
