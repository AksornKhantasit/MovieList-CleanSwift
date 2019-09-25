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
      let result: Result<[Results], Error>
    }
    
    struct ViewModel {
      struct MovieViewModel {
        let id: Int
        let title: String
        let popular: String
        let rating: String
        let movieImage: URL?
        let backdropImage: URL?
        
      }
      var viewModel: Result<[MovieViewModel], Error>
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
      let sortBy: SortB
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

enum SortB: String {
  case desc
  case asc
}
