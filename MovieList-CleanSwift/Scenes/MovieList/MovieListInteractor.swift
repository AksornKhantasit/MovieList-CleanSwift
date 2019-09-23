//
//  MovieListInteractor.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 22/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

import UIKit
/*
protocol MovieListInteractorInterface {
  func doSomething(request: MovieList.GetMovies.Request)
  var model: Entity? { get }
}

class MovieListInteractor: MovieListInteractorInterface {
  var presenter: MovieListPresenterInterface!
  var worker: MovieListWorker?
  var model: Entity?

  // MARK: - Business logic

  func doSomething(request: MovieList.GetMovies.Request) {
    worker?.doSomeWork { [weak self] in
      if case let Result.success(data) = $0 {
        // If the result was successful, we keep the data so that we can deliver it to another view controller through the router.
        self?.model = data
      }

      // NOTE: Pass the result to the Presenter. This is done by creating a response model with the result from the worker. The response could contain a type like UserResult enum (as declared in the SCB Easy project) with the result as an associated value.
      let response = MovieList.GetMovies.Response()
      self?.presenter.presentSomething(response: response)
    }
  }
}
*/
