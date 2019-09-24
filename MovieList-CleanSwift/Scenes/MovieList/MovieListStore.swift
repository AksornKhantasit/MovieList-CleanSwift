//
//  MovieListStore.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 22/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

import Foundation

class MovieListStore: MovieListStoreProtocol {
  
  func getMovies(page: Int, sortBy: String, _ completion: @escaping (Result<Movie, APIError>) -> Void) {
    
    let apiManager = APIManager()
    apiManager.getMovies(page: page, sortBy: sortBy) { (result) in
      DispatchQueue.main.sync {
        completion(result)
      }
    }
  }
}

