//
//  MovieDetailStore.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 23/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

import Foundation

class MovieDetailStore: MovieDetailStoreProtocol {
  
  func getMovieDetail(id: Int, _ completion: @escaping (Result<MovieDetail, APIError>) -> Void) {
    let apiManager = APIManager()
    apiManager.getMovieDetail(id: id) { (result) in
      DispatchQueue.main.sync {
        completion(result)
      }
    }
  }
}
