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
  func setSelectedID(request: MovieList.SetSelectedIndex.Request)
  func setSort(request: MovieList.SetSort.Request)
  func pullRefresh(request: MovieList.PullRefresh.Request)
  var movies: [Results]? { get }
  var selectedID: Int? { get }
}

class MovieListInteractor: MovieListInteractorInterface {
  
  var presenter: MovieListPresenterInterface!
  var worker: MovieListWorker?
  var movies: [Results]?
  var page: Int = 1
  var selectedID: Int?
  var sortBy: SortB = .desc
  
  // MARK: - Business logic
  
  func getMovies(request: MovieList.GetMovies.Request) {
    worker?.getMovies(page: page, sortBy: sortBy.rawValue) { [weak self] apiResponse in
      switch apiResponse {
      case .success(let movies):
        if self?.page == 1 {
          self?.movies = movies.results
        }
        else {
          self?.movies?.append(contentsOf: movies.results)
        }
        let response = MovieList.GetMovies.Response(result: .success(self?.movies ?? []))
        self?.presenter.presentMovies(response: response)
        self?.page += 1
      case .failure(let error):
        let response = MovieList.GetMovies.Response(result: .failure(error))
        self?.presenter.presentMovies(response: response)
      }
    }
  }
  
  func setSelectedID(request: MovieList.SetSelectedIndex.Request) {
    selectedID = request.id
    let response = MovieList.SetSelectedIndex.Response()
    presenter.presentSelectedIndex(response: response)
  }
  
  func setSort(request: MovieList.SetSort.Request) {
    switch request.sortBy {
    case .asc:
      sortBy = .asc
      page = 1
    case .desc:
      sortBy = .desc
      page = 1
    }
    let response = MovieList.SetSort.Response()
    presenter.SetSort(response: response)
  }
  
  func pullRefresh(request: MovieList.PullRefresh.Request) {
    page = 1
    let response = MovieList.PullRefresh.Response()
    presenter.pullRefresh(response: response)
  }
}
