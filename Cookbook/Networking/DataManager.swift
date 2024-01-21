//
//  DataManager.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 20.01.2024.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    func fetchData<T: Decodable>(for url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                let dataError = NSError(domain: "YourAppDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(dataError))
                return
            }
    
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch let decoderError {
                completion(.failure(decoderError))
            }
         
        }.resume()
    }
}
