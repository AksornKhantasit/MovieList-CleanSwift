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

  var presenter: MovieListPresenter!
  var movieListPresenterOutputsSpy: MovieListPresenterOutputsSpy!

  class MovieListPresenterOutputsSpy: MovieListViewControllerInterface {
    
    var displayMoviesCalled = false
    var displaySelectedIndexCalled = false
    var displaySortCalled = false
    var displayPullRefreshCalled = false
    var displayReloadCellCalled = false
    var displayMoviesViewModel: MovieList.GetMovies.ViewModel?
    var displaySelectedIndexViewModel: MovieList.SetSelectedIndex.ViewModel?
    var displaySortViewModel: MovieList.SetSort.ViewModel?
    var displayPullRefreshViewModel: MovieList.PullRefresh.ViewModel?
    var displayReloadCellViewModel: MovieList.ReloadCell.ViewModel?
    
    func displayMovies(viewModel: MovieList.GetMovies.ViewModel){
      displayMoviesCalled = true
      displayMoviesViewModel = viewModel
    }
    
    func displaySelectedIndex(viewModel: MovieList.SetSelectedIndex.ViewModel){
      displaySelectedIndexCalled = true
      displaySelectedIndexViewModel = viewModel
    }
    
    func displaySort(viewModel: MovieList.SetSort.ViewModel) {
      displaySortCalled = true
      displaySortViewModel = viewModel
    }
    
    func displayPullRefresh(viewModel: MovieList.PullRefresh.ViewModel) {
      displayPullRefreshCalled = true
      displayPullRefreshViewModel = viewModel
    }
    
    func displayReloadCell(viewModel: MovieList.ReloadCell.ViewModel) {
      displayReloadCellCalled = true
      displayReloadCellViewModel = viewModel
    }
  }
  
    // MARK: - Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupMovieListPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMovieListPresenter() {
    presenter = MovieListPresenter()
    movieListPresenterOutputsSpy = MovieListPresenterOutputsSpy()
    
  }

  // MARK: - Test doubles

  // MARK: - Tests
  
  func testPresentMovieShouldAskViewControllerToDisplayMoviesWithSuccess() {
    // Given
    presenter.viewController = movieListPresenterOutputsSpy
    
    // When
    let results = [Results(id: 1, popularity: 1, voteCount: 1, voteAverage: 1, title: "test", overview: "test", backdropPath: "/test.jpg", posterPath: "/test.jpg")]
    let response = MovieList.GetMovies.Response(result: .success(results))
    presenter.presentMovies(response: response)
    
    // Then
    XCTAssert(movieListPresenterOutputsSpy.displayMoviesCalled, "presentMovies() should ask view controller to displayMovies()")
    if let viewModel = movieListPresenterOutputsSpy.displayMoviesViewModel {
      switch viewModel.viewModel {
      case .success(let movieViewModels):
        XCTAssertEqual(movieViewModels.first?.id, 1)
        XCTAssertEqual(movieViewModels.first?.title, "test")
        XCTAssertEqual(movieViewModels.first?.popular, "1.00")
        XCTAssertEqual(movieViewModels.first?.movieImage?.absoluteString, "https://image.tmdb.org/t/p/original/test.jpg")
        XCTAssertEqual(movieViewModels.first?.backdropImage?.absoluteString, "https://image.tmdb.org/t/p/original/test.jpg")
        
      default:
        XCTFail()
      }
    } else {
      XCTFail()
    }
  }

  func testPresentMovieShouldAskViewControllerToDisplayMoviesWithFailureByInvalidData() {
    // Given
    presenter.viewController = movieListPresenterOutputsSpy
    // When
    let response = MovieList.GetMovies.Response(result: .failure(APIError.invalidData))
    presenter.presentMovies(response: response)
    // Then
    XCTAssert(movieListPresenterOutputsSpy.displayMoviesCalled)
    if let viewModel = movieListPresenterOutputsSpy.displayMoviesViewModel {
      switch viewModel.viewModel {
      case .failure :
        break
      default:
        XCTFail()
      }
    }
  }
  
  func testPresentMovieShouldAskViewControllerToDisplayMoviesWithFailureByInvalidJSON() {
    // Given
    presenter.viewController = movieListPresenterOutputsSpy
    // When
    let response = MovieList.GetMovies.Response(result: .failure(APIError.invalidJSON))
    presenter.presentMovies(response: response)
    // Then
    XCTAssert(movieListPresenterOutputsSpy.displayMoviesCalled)
    if let viewModel = movieListPresenterOutputsSpy.displayMoviesViewModel {
      var isFail = false
      switch viewModel.viewModel {
      case .failure :
        isFail = true
      default:
        isFail = false
      }
      XCTAssertTrue(isFail)
    }
  }
  
  func testPresentSelectedIndexShouldAskViewControllerToDisplaySelectedIndex() {
    // Given
    presenter.viewController = movieListPresenterOutputsSpy
    //When
    let response = MovieList.SetSelectedIndex.Response()
    presenter.presentSelectedIndex(response: response)
    // Then
    XCTAssert(movieListPresenterOutputsSpy.displaySelectedIndexCalled)
    
  }
  
  func testSetSortShouldAskViewControllerToDisplaySort() {
    // Given
    presenter.viewController = movieListPresenterOutputsSpy
    //When
    let response = MovieList.SetSort.Response()
    presenter.SetSort(response: response)
    //Then
    XCTAssert(movieListPresenterOutputsSpy.displaySortCalled)
  }
  
  func testPullRefresh() {
    // Given
    presenter.viewController =  movieListPresenterOutputsSpy
    //When
    let response = MovieList.PullRefresh.Response()
    presenter.pullRefresh(response: response)
    //Then
    XCTAssert(movieListPresenterOutputsSpy.displayPullRefreshCalled)
  }
  
  func testReloadCell() {
    // Given
    presenter.viewController =  movieListPresenterOutputsSpy
    //When
    let response = MovieList.ReloadCell.Response(movie: Results(id: 1, popularity: 1, voteCount: 1, voteAverage: 1, title: "test", overview: "test", backdropPath: "/test.jpg", posterPath: "/test.jpg"), movieId: 1)
    presenter.reloadCell(response: response)
    //Then
    XCTAssert(movieListPresenterOutputsSpy.displayReloadCellCalled)
    
    if let viewModel = movieListPresenterOutputsSpy.displayReloadCellViewModel {
      XCTAssertEqual(viewModel.viewModel.id, 1)
      XCTAssertEqual(viewModel.viewModel.title, "test")
      XCTAssertEqual(viewModel.viewModel.popular, "1.00")
      XCTAssertEqual(viewModel.viewModel.movieImage?.absoluteString, "https://image.tmdb.org/t/p/original/test.jpg")
      XCTAssertEqual(viewModel.viewModel.backdropImage?.absoluteString, "https://image.tmdb.org/t/p/original/test.jpg")
    }
  }
}
