//
//  MovieListInteractor.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 22/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

import UIKit

protocol MovieListInteractorInterface {
  func getMovies(request: MovieList.GetMovies.Request)
  var movies: [Results]? { get }
}

class MovieListInteractor: MovieListInteractorInterface {
    var presenter: MovieListPresenterInterface!
    var worker: MovieListWorker?
    var movies: [Results]?
    var page: Int = 1
    enum SortB : String{
        case desc
        case asc
    }
    var sortBy: SortB = .desc

  // MARK: - Business logic

  func getMovies(request: MovieList.GetMovies.Request) {
    worker?.getMovies(page: page, sortBy: sortBy.rawValue) { [weak self] apiResponse in
        switch apiResponse {
        case .success(let movies):
            self?.movies = movies.results
            let response = MovieList.GetMovies.Response(movies: movies.results)
            self?.presenter.presentMovies(response: response)
            self?.page += 1
        case .failure(let error):
            print(error) // show error
        }

//      if case let Result.success(data) = $0 {
//        // If the result was successful, we keep the data so that we can deliver it to another view controller through the router.
//        self?.model = data
//      }
//
//      // NOTE: Pass the result to the Presenter. This is done by creating a response model with the result from the worker. The response could contain a type like UserResult enum (as declared in the SCB Easy project) with the result as an associated value.
//      let response = MovieList.GetMovies.Response()
//      self?.presenter.presentSomething(response: response)
    }
  }
}
