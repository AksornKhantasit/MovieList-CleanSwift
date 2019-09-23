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
}

class MovieListPresenter: MovieListPresenterInterface {
  weak var viewController: MovieListViewControllerInterface!

  // MARK: - Presentation logic

  func presentMovies(response: MovieList.GetMovies.Response) {
    let movies = response.movies
    var movieViewModels: [MovieList.GetMovies.ViewModel.MovieViewModel] = []
    // NOTE: Format the response from the Interactor and pass the result back to the View Controller. The resulting view model should be using only primitive types. Eg: the view should not need to involve converting date object into a formatted string. The formatting is done here.
    for movie in movies {
        let title = movie.title
        let popular = String(format: "%.2f", movie.popularity)
        let rating = "\(movie.voteAverage)"
        let movieImageURL = movie.posterPath
        let backdropImageURL = movie.backdropPath
        let MovieViewModel = MovieList.GetMovies.ViewModel.MovieViewModel(title: title, popular: popular, rating: rating, movieImage: movieImageURL, backdropImage: backdropImageURL)
        movieViewModels.append(MovieViewModel)
    }
    let viewModel = MovieList.GetMovies.ViewModel(movieViewModels: movieViewModels)
    viewController.displayMovies(viewModel: viewModel)
  }
}

