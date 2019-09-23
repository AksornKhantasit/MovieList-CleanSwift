//
//  APIManager.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 23/9/2562 BE.
//  Copyright © 2562 Aksorn. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidJSON
    case invalidData
}

class APIManager {
    func getMovies(page: Int, sortBy: String, completion: @escaping (Result<Movie, APIError>) -> Void) {
        let urlString = "http://api.themoviedb.org/3/discover/movie?api_key=328c283cd27bd1877d9080ccb1604c91&primary_release_date.lte=2016-12-31&sort_by=release_date.\(sortBy)&page=\(page)"
        request(urlString: urlString, completion: completion)
    }
    
    private func request<T: Codable>(urlString: String, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completion(.failure(.invalidData))
            } else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    do {
                        let values = try JSONDecoder().decode(T.self, from: data)
                        print(values)
                        completion(.success(values))
                    } catch(let error2) {
                        completion(.failure(.invalidJSON))
                    }
                }
            }
        }
        task.resume()
    }
 
//    func getMovies<T: Codable>(urlString: String, completion: @escaping (Result<T, APIError>) -> Void) {
//        guard let url = URL(string: urlString) else {
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let _ = error {
//                completion(.failure(.invalidData))
//            } else if let data = data, let response = response as? HTTPURLResponse {
//                if response.statusCode == 200 {
//                    do {
//                        let values = try JSONDecoder().decode(T.self, from: data)
//                        print(values)
//                        completion(.success(values))
//                    } catch {
//                        completion(.failure(.invalidJSON))
//                    }
//                }
//            }
//        }
//        task.resume()
//    }
    
}
