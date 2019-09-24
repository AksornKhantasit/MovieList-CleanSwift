//
//  MovieDetailInteractor.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 23/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

import UIKit

protocol MovieDetailInteractorInterface {
  func getMovieDetail(request: MovieListDetail.GetMovieDetail.Request)
  func setRating(request: MovieListDetail.SetRating.Request)
  var movie: MovieDetail? { get set }
  var id: Int? { get set }
  
}

class MovieDetailInteractor: MovieDetailInteractorInterface {
  var presenter: MovieDetailPresenterInterface!
  var worker: MovieDetailWorker?
  var movie: MovieDetail?
  var id: Int? = 0
  var avg = 0.0
  
  // MARK: - Business logic
  
  func getMovieDetail(request: MovieListDetail.GetMovieDetail.Request) {
    if let id = id {
      worker?.getMovieDetail(id: id) { [weak self] apiResponse in
        switch apiResponse {
        case .success(let movies):
          self?.movie = movies
          let response = MovieListDetail.GetMovieDetail.Response(movie: movies)
          self?.presenter.presentMovieDetail(response: response)
        case .failure(let error):
          print(error)
        }
      }
    }
  }
  
  func setRating(request: MovieListDetail.SetRating.Request) {
    if let id = id , let movie = movie {
      UserDefaults.standard.set(request.rating , forKey: "rating\(id)")
      avg = ((movie.voteAverage * movie.voteCount) + request.rating)/(movie.voteCount + 1)
      UserDefaults.standard.set( avg , forKey: "avg\(id)")
      print(avg)
    }
  }
}
