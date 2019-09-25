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
    let movies = response.result
    var movieViewModels: [MovieList.GetMovies.ViewModel.MovieViewModel] = []
    
    switch movies {
    case .success(let moviee):
      for movie in moviee {
        let id = movie.id
        let title = movie.title
        let popular = String(format: "%.2f", movie.popularity)

        let rating = "\(movie.voteAverage)"
//        let getavg = UserDefaults.standard.double(forKey: "avg\(movie.id)")
//        var rating = ""
//        if getavg == 0.0 {
//          rating = "\(movie.voteAverage)"
//          //rating.text = String(movie.rating)
//        }
//        else {
//          rating = String(format: "%.1f", getavg )
//          //rating.text = String(format: "%.1f", getavg ?? 0.0)
//        }
        
        let baseURL = "https://image.tmdb.org/t/p/original"
        let posterPath = movie.posterPath
        let backdropPath = movie.backdropPath
        let posterURL = URL(string: "\(baseURL)\(posterPath ?? "")")
        let backdropURL = URL(string: "\(baseURL)\(backdropPath ?? "")")
        
        let MovieViewModel = MovieList.GetMovies.ViewModel.MovieViewModel(id: Int(id), title: title, popular: popular, rating: rating, movieImage: posterURL, backdropImage: backdropURL)
        
        movieViewModels.append(MovieViewModel)
        
        let viewModel = MovieList.GetMovies.ViewModel(viewModel: .success(movieViewModels))
        viewController.displayMovies(viewModel: viewModel)
      }
    case.failure(let error):
      print(error)
      let viewModel = MovieList.GetMovies.ViewModel(viewModel: .failure(error))
      viewController.displayMovies(viewModel: viewModel)
    }
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

