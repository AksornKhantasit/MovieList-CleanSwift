//
//  MovieListWorker.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 22/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

import UIKit

protocol MovieListStoreProtocol {
  func getMovies(page: Int, sortBy: String, _ completion: @escaping (Result<Movie, APIError>) -> Void)
}

class MovieListWorker {
  
  var store: MovieListStoreProtocol
  
  init(store: MovieListStoreProtocol) {
    self.store = store
  }
  
  // MARK: - Business Logic
  
  func getMovies(page: Int, sortBy: String, _ completion: @escaping (Result<Movie, APIError>) -> Void) {
    store.getMovies(page: page, sortBy: sortBy) { result in
      completion(result)
    }
  }
}

