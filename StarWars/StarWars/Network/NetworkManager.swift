//
//  NetworkManager.swift
//  StarWars
//
//  Created by Consultant on 5/16/22.
//

import Foundation

class NetworkManager {
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}

extension NetworkManager {
    
    func fetchCharacter(offset: Int, completion: @escaping (Result<Characters, Error>) -> Void) {
                        
        guard let url = URL(string: "https://swapi.dev/api/people/?page=\(offset)&format=json") else {
            print("error with url")
            return
            }
        
        self.session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.badServerResponse(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.badData))
                return
            }

            do {
                let pageResult = try JSONDecoder().decode(Characters.self, from: data)
                completion(.success(pageResult))
            } catch {
                completion(.failure(NetworkError.decodeError("\(error)")))
            }
            
        }.resume()
    }
    
    func fetchPlanetInfo(urlPath: String, completion: @escaping (Result<Planet, Error>) -> Void) {
        guard let url = URL(string: "\(urlPath)" + "?format=json") else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        self.session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.badServerResponse(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.badData))
                return
            }

            do {
                let pageResult = try JSONDecoder().decode(Planet.self, from: data)
                completion(.success(pageResult))
            } catch {
                completion(.failure(NetworkError.decodeError("\(error)")))
            }
            
        }.resume()
    }
}
