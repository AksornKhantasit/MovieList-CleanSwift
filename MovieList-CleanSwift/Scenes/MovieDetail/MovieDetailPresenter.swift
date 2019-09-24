//
//  MovieDetailPresenter.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 23/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

import UIKit

protocol MovieDetailPresenterInterface {
  func presentMovieDetail(response: MovieListDetail.GetMovieDetail.Response)
}

class MovieDetailPresenter: MovieDetailPresenterInterface {
  weak var viewController: MovieDetailViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentMovieDetail(response: MovieListDetail.GetMovieDetail.Response) {
    let movieImageURL = response.movie.posterPath
    let title = response.movie.title
    let popular = "\(response.movie.popularity)"
    let overview = response.movie.overview
    var strCategory: [String] = []
    for category in response.movie.genres {
      strCategory.append(category.name)
    }
    let category = strCategory.joined(separator: " , ")
    let language = response.movie.Language
    let id = Int(response.movie.id)
    let rated = (UserDefaults.standard.double(forKey: "rating\(id)"))/2
    print("getRating : \(rated)")
    let viewModel = MovieListDetail.GetMovieDetail.ViewModel(movieImage: movieImageURL,title: title, popular: popular, overview: overview, category: category, language: language, rating: rated)
    
    viewController.displayData(viewModel: viewModel)
    
  }
}


