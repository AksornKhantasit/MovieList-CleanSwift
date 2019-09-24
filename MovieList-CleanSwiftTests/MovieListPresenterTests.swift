//
//  MovieListPresenterTests.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 24/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

@testable import MovieList_CleanSwift
import XCTest

class MovieListPresenterTests: XCTestCase {

  // MARK: - Subject under test

  var sut: MovieListPresenter!
  var movieListPresenterOutputsSpy : MovieListPresenterOutputsSpy!

  // MARK: - Test lifecycle
  class MovieListPresenterOutputsSpy : MovieListViewControllerInterface {
    var displayMoviesCalled = false
    var displaySelectedIndexCalled = false
    var displayMoviesViewModel : MovieList.GetMovies.ViewModel?
    
    func displayMovies(viewModel: MovieList.GetMovies.ViewModel){
      displayMoviesCalled = true
      displayMoviesViewModel = viewModel
    }
    func displaySelectedIndex(viewModel: MovieList.SetSelectedIndex.ViewModel){
      displaySelectedIndexCalled = true
    }
  }
  
  override func setUp() {
    super.setUp()
    setupMovieListPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMovieListPresenter() {
    sut = MovieListPresenter()
    movieListPresenterOutputsSpy = MovieListPresenterOutputsSpy()
    
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testSomething() {
    // Given
    sut.viewController = movieListPresenterOutputsSpy
    
    // When
    sut.presentMovies(response: MovieList.GetMovies.Response(movies: [Results(id: 0.0, popularity: 0.0, voteCount: 0.0, voteAverage: 0.0, title: "", overview: "", backdropPath: "", posterPath: "")]))
    
    // Then
    XCTAssert(movieListPresenterOutputsSpy.displayMoviesCalled)
  XCTAssertEqual(movieListPresenterOutputsSpy.displayMoviesViewModel?.movieViewModels.first?.id, 0)
    
    
  }
  
  func testblablabla() {
    //given
    sut.viewController = movieListPresenterOutputsSpy
    
    //When
    sut.presentSelectedIndex(response: MovieList.SetSelectedIndex.Response())
    
    //Then
    //XCTAssert(movieListPresenterOutputsSpy.)
    
    
  }
}
