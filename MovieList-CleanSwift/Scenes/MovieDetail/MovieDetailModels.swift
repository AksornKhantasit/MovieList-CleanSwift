//
//  MovieDetailModels.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 23/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

import UIKit

struct MovieListDetail {
  
  struct GetMovieDetail {
    struct Request {}
    struct Response {
        let movie: MovieDetail
    }
    struct ViewModel {
        let movieImage: String?
        let title: String
        let popular: String
        let overview: String
        let category: String
        let language: String
        let rating: Double
    }
  }
  
  struct SetRating {
    struct Request {
      let rating: Double
    }
    struct Response {}
    struct ViewModel {}
  }
}
