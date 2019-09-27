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
  func presentGetMovieId(respense: MovieListDetail.getmoiveId.Response)
}

class MovieDetailPresenter: MovieDetailPresenterInterface {
  
  weak var viewController: MovieDetailViewControllerInterface!
  
  // MARK: - Presentation logic

  func presentMovieDetail(response: MovieListDetail.GetMovieDetail.Response) {
    let movie = response.movieDetail
    
    switch movie {
    case .success(let movie):
      let baseURL = "https://image.tmdb.org/t/p/original"
      let posterPath = movie.posterPath
      let posterURL = URL(string: "\(baseURL)\(posterPath ?? "")")

      let title = movie.title
      let popular = String(format: "%.2f", movie.popularity)
      let overview = movie.overview
      
      var strCategory: [String] = []
      for category in movie.genres {
        strCategory.append(category.name)
      }
      let category = strCategory.joined(separator: " , ")
      
      let language = movie.Language
      let id = Int(movie.id )
      let rated = (UserDefaults.standard.double(forKey: "rating\(id)"))/2
      print("getRating : \(rated)")
  
      let moviedetail = MovieListDetail.GetMovieDetail.ViewModel.data(movieImage: posterURL, title: title, popular: popular, overview: overview, category: category, language: language, rating: rated)
      
       let viewModel = MovieListDetail.GetMovieDetail.ViewModel(viewModel: .success(moviedetail))
      viewController.displayData(viewModel: viewModel)
   
    case .failure(let error):
      print(error)
      let viewModel = MovieListDetail.GetMovieDetail.ViewModel(viewModel: .failure(error))
      viewController.displayData(viewModel: viewModel)
    }
  }
  
  func presentGetMovieId(respense: MovieListDetail.getmoiveId.Response) {
    
    let movieId = MovieListDetail.getmoiveId.ViewModel.GetMovieId(movieId: respense.movieId)
    let viewModel = MovieListDetail.getmoiveId.ViewModel(viewmodel: movieId)
    viewController.displayGetMovieId(viewModel: viewModel)
  }
}


