//
//  MovieDetailInteractorTests.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 27/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

@testable import MovieList_CleanSwift
import XCTest

class MovieDetailInteractorTests: XCTestCase {

  // MARK: - Subject under test

  var sut: MovieDetailInteractor!
  var movieDetailInteractorOutputsSpy: MovieDetailInteractorOutputsSpy!
  var movieDetailWorkerOutputsSpy: MovieDetailWorkerOutputsSpy!
  
  class MovieDetailInteractorOutputsSpy : MovieDetailPresenterInterface {
    
    var presentMovieDetailCalled = false
    var presentGetMovieIdCalled = false
    var presentMovieDetailResponse: MovieListDetail.GetMovieDetail.Response?
    var presentGetMovieIdResponse: MovieListDetail.getmoiveId.Response?
    
    func presentMovieDetail(response: MovieListDetail.GetMovieDetail.Response) {
      presentMovieDetailCalled = true
      presentMovieDetailResponse = response
    }
    
    func presentGetMovieId(respense: MovieListDetail.getmoiveId.Response) {
      presentGetMovieIdCalled = true
      presentGetMovieIdResponse = respense
    }
  }
  
  class MovieDetailWorkerOutputsSpy: MovieDetailWorker {
    
    var getMoviesCalledBySuceess = false
    var getMoviesCalledByFaild = false
    var forcesError = false
    
    override func getMovieDetail(id: Int, _ completion: @escaping (Result<MovieDetail, APIError>) -> Void) {
      if forcesError {
        getMoviesCalledByFaild = true
        completion(Result<MovieDetail,APIError>.failure(APIError.invalidData))
      } else {
        getMoviesCalledBySuceess = true
        completion(Result<MovieDetail,APIError>.success(MovieDetail(id: 1, posterPath: "/test.jpg", title: "test", popularity: 1, overview: "test", genres: [Genres(name: "test")], Language: "test", voteCount: 1, voteAverage: 1)))
      }
    }
  }
  
  

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupMovieDetailInteractor()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMovieDetailInteractor() {
    sut = MovieDetailInteractor()
    movieDetailInteractorOutputsSpy = MovieDetailInteractorOutputsSpy()
    movieDetailWorkerOutputsSpy = MovieDetailWorkerOutputsSpy(store: MovieDetailStore())
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testGetMovieDetailShouldAskPresenterToPresentMovieDetailsWithSuccess() {
    
    // Given
    sut.presenter = movieDetailInteractorOutputsSpy
    sut.worker = movieDetailWorkerOutputsSpy
    movieDetailWorkerOutputsSpy.forcesError = false

    // When
    let request = MovieListDetail.GetMovieDetail.Request()
    sut.getMovieDetail(request: request)
    
    // Then
    XCTAssert(movieDetailWorkerOutputsSpy.getMoviesCalledBySuceess)
    XCTAssert(movieDetailInteractorOutputsSpy.presentMovieDetailCalled)
    
  }
  
  func testGetMovieDetailShouldAskPresenterToPresentMovieDetailsWithFailure() {
    
    // Given
    sut.presenter = movieDetailInteractorOutputsSpy
    sut.worker = movieDetailWorkerOutputsSpy
    movieDetailWorkerOutputsSpy.forcesError = true
    
    // When
    let request = MovieListDetail.GetMovieDetail.Request()
    sut.getMovieDetail(request: request)
    
    // Then
    XCTAssert(movieDetailWorkerOutputsSpy.getMoviesCalledByFaild)
    XCTAssert(movieDetailInteractorOutputsSpy.presentMovieDetailCalled)
  }
  
  func testGetmovieIdShouldAskPresenterToPresentGetMovieId() {
    // Given
    sut.presenter = movieDetailInteractorOutputsSpy
    // When
    let request = MovieListDetail.getmoiveId.Request()
    sut.getmovieId(request: request)
    // Then
    XCTAssert(movieDetailInteractorOutputsSpy.presentGetMovieIdCalled)
    
    
  }
  
  
}
