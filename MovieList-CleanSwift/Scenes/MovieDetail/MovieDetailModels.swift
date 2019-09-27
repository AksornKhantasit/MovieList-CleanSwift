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
        let movieDetail: Result<MovieDetail, Error>
    }
    struct ViewModel {
      struct data {
        let movieImage: URL?
        let title: String
        let popular: String
        let overview: String
        let category: String
        let language: String
        let rating: Double
      }
      var viewModel: Result<data, Error>
    }
  }
  
  struct SetRating {
    struct Request {
      let rating: Double
    }
    struct Response {}
    struct ViewModel {}
  }
  struct getmoiveId {
    struct Request {
    }
    struct Response {
      let movieId: Int
    }
    struct ViewModel {
      struct GetMovieId {
        let movieId: Int
      }
      let viewmodel : GetMovieId
    }
  }
}
