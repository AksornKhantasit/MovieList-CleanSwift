//
//  MovieListModels.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 22/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

import UIKit

struct MovieList {
  
  struct GetMovies {
    struct Request {}
    struct Response {
      let movies: [Results]
    }
    
    struct ViewModel {
      struct MovieViewModel {
        let id: Int
        let title: String
        let popular: String
        let rating: String
        let movieImage: String?
        let backdropImage: String?
        
      }
      var movieViewModels: [MovieViewModel]
    }
  }
  
  struct SetSelectedIndex {
    struct Request {
      let id: Int
    }
    struct Response {}
    struct ViewModel {}
  }
  
  struct SetSort {
    struct Request {
      let sortBy: String
    }
    struct Response {}
    struct ViewModel {}
  }
  
  struct PullRefresh  {
    struct Request {}
    struct Response {}
    struct ViewModel {}
  }
}
