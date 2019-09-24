//
//  MovieListPresenter.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 22/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

import UIKit

protocol MovieListPresenterInterface {
  func presentMovies(response: MovieList.GetMovies.Response)
  func presentSelectedIndex(response: MovieList.SetSelectedIndex.Response)
  func SetSort(response: MovieList.SetSort.Response)
  func pullRefresh(response: MovieList.PullRefresh.Response)
}

class MovieListPresenter: MovieListPresenterInterface {
  weak var viewController: MovieListViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentMovies(response: MovieList.GetMovies.Response) {
    let movies = response.movies
    var movieViewModels: [MovieList.GetMovies.ViewModel.MovieViewModel] = []
    
    for movie in movies {
      let id = movie.id
      let title = movie.title
      let popular = String(format: "%.2f", movie.popularity)
      let rating = "\(movie.voteAverage)"
      let movieImageURL = movie.posterPath
      let backdropImageURL = movie.backdropPath
      let MovieViewModel = MovieList.GetMovies.ViewModel.MovieViewModel(id: Int(id), title: title, popular: popular, rating: rating, movieImage: movieImageURL, backdropImage: backdropImageURL)
      movieViewModels.append(MovieViewModel)
    }
    
    let viewModel = MovieList.GetMovies.ViewModel(movieViewModels: movieViewModels)
    viewController.displayMovies(viewModel: viewModel)
  }
  
  func presentSelectedIndex(response: MovieList.SetSelectedIndex.Response) {
    let viewModel = MovieList.SetSelectedIndex.ViewModel()
    viewController.displaySelectedIndex(viewModel: viewModel)
  }
  func SetSort(response: MovieList.SetSort.Response){
    let viewModel = MovieList.SetSort.ViewModel()
    viewController.displaySort(viewModel: viewModel)
  }
  func pullRefresh(response: MovieList.PullRefresh.Response) {
    let viewModel = MovieList.PullRefresh.ViewModel()
    viewController.displayPullRefresh(viewModel: viewModel)
  }
  
}

