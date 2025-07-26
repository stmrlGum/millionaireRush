//
//  NetworkManager.swift
//  millionaireRush
//
//  Created by Danil on 24.07.2025.
//

import Foundation

class NetworkManager {
    
    let url = "https://opentdb.com/api.php?amount=15&type=multiple"
    
    static let shared = NetworkManager()
    

    func getData(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    completion(.success(jsonObject))
                } else {
                    completion(.failure(error!))
                }
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }

}
