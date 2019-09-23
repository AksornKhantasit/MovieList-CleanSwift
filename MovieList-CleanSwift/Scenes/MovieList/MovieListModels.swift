//
//  MovieListModels.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 22/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

import UIKit

struct MovieList {
  /// This structure represents a use case
  struct GetMovies {
    /// Data struct sent to Interactor
    struct Request {}
    /// Data struct sent to Presenter
    struct Response {
        let movies: [Results]
    }
    /// Data struct sent to ViewController
    struct ViewModel {
        struct MovieViewModel {
            let title: String
            let popular: String
            let rating: String
            let movieImage: String?
            let backdropImage: String?
        }
        var movieViewModels: [MovieViewModel]
    }
  }
}
