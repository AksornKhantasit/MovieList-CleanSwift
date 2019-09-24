//
//  MovieDetailWorker.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 23/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

import UIKit

protocol MovieDetailStoreProtocol {
  func getMovieDetail(id: Int, _ completion: @escaping (Result<MovieDetail, APIError>) -> Void)
}

class MovieDetailWorker {
  
  var store: MovieDetailStoreProtocol
  
  init(store: MovieDetailStoreProtocol) {
    self.store = store
  }
  
  // MARK: - Business Logic
  
  func getMovieDetail(id: Int, _ completion: @escaping (Result<MovieDetail, APIError>) -> Void) {
    store.getMovieDetail(id: id) { result in
      completion(result)
    }
  }
}
