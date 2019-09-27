//
//  MovieListInteractorTests.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 24/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

@testable import MovieList_CleanSwift
import XCTest

class MovieListInteractorTests: XCTestCase {

  // MARK: - Subject under test

  var sut: MovieListInteractor!
  var movieListWorkerOutputsSpy: MovieListWorkerOutputsSpy!
  var movieListInteractorOutputsSpy: MovieListInteractorOutputsSpy!

  class MovieListInteractorOutputsSpy: MovieListPresenterInterface {
    
    var presentMoviesCalled = false // mispell
    var presentSelectedIndexCalled = false
    var setSortCalled = false
    var pullRefreshCalled = false
    var reloadCellCalled = false
    var presentMoviesResponse: MovieList.GetMovies.Response?
    var presentSelectedIndexResponse: MovieList.SetSelectedIndex.Response?
    var setSortResponse: MovieList.SetSort.Response?
    var pullRefreshResponse: MovieList.PullRefresh.Response?
    var reloadCellResponse: MovieList.ReloadCell.Response?
    
    func presentMovies(response: MovieList.GetMovies.Response) {
      presentMoviesCalled = true
      presentMoviesResponse = response
    }
    
    func presentSelectedIndex(response: MovieList.SetSelectedIndex.Response) {
      presentSelectedIndexCalled = true
      presentSelectedIndexResponse = response
    }
    
    func setSort(response: MovieList.SetSort.Response) {
      setSortCalled = true
      setSortResponse = response
    }
    
    func pullRefresh(response: MovieList.PullRefresh.Response) {
      pullRefreshCalled = true
      pullRefreshResponse = response
    }
    
    func reloadCell(response: MovieList.ReloadCell.Response) {
      reloadCellCalled = true
      reloadCellResponse = response
    }  
  }
  
  class MovieListWorkerOutputsSpy: MovieListWorker {
    
    var getMoviesCalledBySuceess = false
    var getMoviesCalledByFaild = false
    var forcesError = false
    
    override func getMovies(page: Int, sortBy: String, _ completion: @escaping (Result<Movie, APIError>) -> Void) {
      if forcesError {
        getMoviesCalledByFaild = true
        completion(Result<Movie,APIError>.failure(APIError.invalidData))
      } else {
        getMoviesCalledBySuceess = true
        completion(Result<Movie,APIError>.success(Movie(page: 1, results: [Results(id: 1, popularity: 1, voteCount: 1, voteAverage: 1, title: "test", overview: "test", backdropPath: "/test.jpg", posterPath: "/test.jpg")])))
      }
    }
  }
  
  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupMovieListInteractor()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMovieListInteractor() {
    sut = MovieListInteractor()
    movieListInteractorOutputsSpy = MovieListInteractorOutputsSpy()
    movieListWorkerOutputsSpy = MovieListWorkerOutputsSpy(store: MovieListStore())
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testGetMoviesShouldAskPresenterToPresentMoviesWithSuccess() {
    
    // Given
    sut.presenter = movieListInteractorOutputsSpy
    sut.worker = movieListWorkerOutputsSpy
    movieListWorkerOutputsSpy.forcesError = false
    
    // When
    let request = MovieList.GetMovies.Request()
    sut.getMovies(request: request)
    
    // Then
    XCTAssert(movieListWorkerOutputsSpy.getMoviesCalledBySuceess)
    XCTAssert(movieListInteractorOutputsSpy.presentMoviesCalled)
  }
  
  func testGetMoviesShouldAskPresenterToPresentMoviesWithFailure() {
    
    // Given
    sut.presenter = movieListInteractorOutputsSpy
    sut.worker = movieListWorkerOutputsSpy
    movieListWorkerOutputsSpy.forcesError = true
    
    // When
    let request = MovieList.GetMovies.Request()
    sut.getMovies(request: request)
    
    // Then
    XCTAssert(movieListWorkerOutputsSpy.getMoviesCalledByFaild)
    XCTAssert(movieListInteractorOutputsSpy.presentMoviesCalled)
  }
  
  func testGetMoviesShouldAskPresenterToPresentMoviesWithSuccessCaseLoadMore() {

    // Given
    sut.page = 2
    sut.presenter = movieListInteractorOutputsSpy
    sut.worker = movieListWorkerOutputsSpy
    movieListWorkerOutputsSpy.forcesError = false
    
    // When
    let request = MovieList.GetMovies.Request()
    sut.getMovies(request: request)
    
    // Then
    XCTAssert(movieListWorkerOutputsSpy.getMoviesCalledBySuceess)
    XCTAssert(movieListInteractorOutputsSpy.presentMoviesCalled)
  }
  
  func testSetSelectedIDShouldAskPresenterToPresentSelectedIndex() {
    
    // Given
    sut.presenter = movieListInteractorOutputsSpy
    
    // When
    let request = MovieList.SetSelectedIndex.Request(id: 1)
    sut.setSelectedID(request: request)
    
    // Then
    XCTAssert(movieListInteractorOutputsSpy.presentSelectedIndexCalled)
  
  }
  
  func testSetSortShouldAskPresenterToSetSortByASC() {
    
    // Given
    sut.presenter = movieListInteractorOutputsSpy
    
    // When
    let request = MovieList.SetSort.Request(sortBy: .asc)
    sut.setSort(request: request)
    
    // Then
    XCTAssert(movieListInteractorOutputsSpy.setSortCalled)
    
  }
  
  func testSetSortShouldAskPresenterToSetSortByDESC() {
    
    // Given
    sut.presenter = movieListInteractorOutputsSpy
    
    // When
    let request = MovieList.SetSort.Request(sortBy: .desc)
    sut.setSort(request: request)
    
    // Then
    XCTAssert(movieListInteractorOutputsSpy.setSortCalled)
    
  }
  
  func testPullRefreshShouldAskPresenterToPullRefresh() {
    
    // Given
    sut.presenter = movieListInteractorOutputsSpy
    
    // When
    let request = MovieList.PullRefresh.Request()
    sut.pullRefresh(request: request)
    
    // Then
    XCTAssert(movieListInteractorOutputsSpy.pullRefreshCalled)
    
  }
  
  
  func testReloadCellShouldAskPresenterToReloadCell() {
    
    // Given
    sut.presenter = movieListInteractorOutputsSpy
    sut.movies = [Results(id: 1, popularity: 1, voteCount: 1, voteAverage: 1, title: "test", overview: "test", backdropPath: "/test.jpg", posterPath: "/test.jpg")]
    
    movieListWorkerOutputsSpy.forcesError = false
    
    // When
    let request = MovieList.ReloadCell.Request(movieId: 1)
    sut.reloadCell(request: request)
    
    // Then
    XCTAssert(movieListInteractorOutputsSpy.reloadCellCalled)
    XCTAssertEqual(movieListInteractorOutputsSpy.reloadCellResponse?.movieId,1)
    
  }
}
