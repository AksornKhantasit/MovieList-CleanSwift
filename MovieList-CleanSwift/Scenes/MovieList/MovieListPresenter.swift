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
  func setSort(response: MovieList.SetSort.Response)
  func pullRefresh(response: MovieList.PullRefresh.Response)
  func reloadCell(response: MovieList.ReloadCell.Response)
}

class MovieListPresenter: MovieListPresenterInterface {
 
  weak var viewController: MovieListViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentMovies(response: MovieList.GetMovies.Response) {
    let movies = response.result
    var movieViewModels: [MovieList.MovieViewModel] = []
    
    switch movies {
    case .success(let moviee):
      for movie in moviee {
        let id = movie.id
        let title = movie.title
        let popular = String(format: "%.2f", movie.popularity)

        let getavg = UserDefaults.standard.double(forKey: "avg\(movie.id)")
        var rating = ""
        if getavg == 0.0 {
           rating = "\(movie.voteAverage)"
        }
        else {
          rating = String(format: "%.1f", getavg )
        }

        let baseURL = "https://image.tmdb.org/t/p/original"
        let posterPath = movie.posterPath
        let backdropPath = movie.backdropPath
        let posterURL = URL(string: "\(baseURL)\(posterPath ?? "")")
        let backdropURL = URL(string: "\(baseURL)\(backdropPath ?? "")")
        
        let movieData = MovieList.MovieViewModel(id: Int(id), title: title, popular: popular, rating: rating, movieImage: posterURL, backdropImage: backdropURL)
        
        
        movieViewModels.append(movieData)
      }
        let viewModel = MovieList.GetMovies.ViewModel(viewModel: .success(movieViewModels))
        viewController.displayMovies(viewModel: viewModel)
      
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
  func setSort(response: MovieList.SetSort.Response){
    let viewModel = MovieList.SetSort.ViewModel()
    viewController.displaySort(viewModel: viewModel)
  }
  func pullRefresh(response: MovieList.PullRefresh.Response) {
    let viewModel = MovieList.PullRefresh.ViewModel()
    viewController.displayPullRefresh(viewModel: viewModel)
  }
  func reloadCell(response: MovieList.ReloadCell.Response) {
    if let movie = response.movie {
      
      let baseURL = "https://image.tmdb.org/t/p/original"
      let posterPath = movie.posterPath
      let backdropPath = movie.backdropPath
      let posterURL = URL(string: "\(baseURL)\(posterPath ?? "")")
      let backdropURL = URL(string: "\(baseURL)\(backdropPath ?? "")")
      let popular = String(format: "%.2f", movie.popularity)
      let getavg = UserDefaults.standard.double(forKey: "avg\(response.movieId)")
      
      let rating = String(format: "%.1f", getavg )
      
      let movieData = MovieList.MovieViewModel(id: Int(movie.id), title: movie.title, popular: popular, rating: rating, movieImage: posterURL, backdropImage: backdropURL)
  
      let viewModel = MovieList.ReloadCell.ViewModel(viewModel: movieData)
      viewController.displayReloadCell(viewModel: viewModel)
    }
    
  }
  
}

