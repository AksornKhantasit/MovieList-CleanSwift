//
//  MovieListStore.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 22/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

import Foundation

/*

 The MovieListStore class implements the MovieListStoreProtocol.

 The source for the data could be a database, cache, or a web service.

 You may remove these comments from the file.

 */


class MovieListStore: MovieListStoreProtocol {
   
    
    
    func getMovies(page: Int, sortBy: String, _ completion: @escaping (Result<Movie, APIError>) -> Void) {
    // Simulates an asynchronous background thread that calls back on the main thread after 2 seconds
        let apiManager = APIManager()
        apiManager.getMovies(page: page, sortBy: sortBy) { (result) in
            DispatchQueue.main.sync {
                completion(result)
            }
        }
//    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//      completion(Result.success(Entity()))
//    }
  }
}

