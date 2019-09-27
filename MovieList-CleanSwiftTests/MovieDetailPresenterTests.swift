//
//  MovieDetailPresenterTests.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 27/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

@testable import MovieList_CleanSwift
import XCTest

class MovieDetailPresenterTests: XCTestCase {

  // MARK: - Subject under test

  var presenter: MovieDetailPresenter!
  var movieDetailPresenterOutputsSpy: MovieDetailPresenterOutputsSpy!
  
  class MovieDetailPresenterOutputsSpy: MovieDetailViewControllerInterface {
    
    var displayDataCalled = false
    var displayGetMovieIdCalled = false
    var displayDataViewModel: MovieListDetail.GetMovieDetail.ViewModel?
    var displayGetMovieIdViewModel: MovieListDetail.getmoiveId.ViewModel?
    
    func displayData(viewModel: MovieListDetail.GetMovieDetail.ViewModel) {
      displayDataCalled = true
      displayDataViewModel = viewModel
    }
    
    func displayGetMovieId(viewModel: MovieListDetail.getmoiveId.ViewModel) {
      displayGetMovieIdCalled = true
      displayGetMovieIdViewModel = viewModel
    }
  }

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupMovieDetailPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMovieDetailPresenter() {
    presenter = MovieDetailPresenter()
    movieDetailPresenterOutputsSpy = MovieDetailPresenterOutputsSpy()
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testPresentMovieDetailShouldAskViewControllerToDisplayDataWithSuccess() {
    // Given
    presenter.viewController = movieDetailPresenterOutputsSpy

    // When
    let movieDetail = MovieDetail(id: 1, posterPath: "/test.jpg", title: "test", popularity: 1, overview: "test", genres: [Genres(name: "test")], Language: "test", voteCount: 1, voteAverage: 1)
    let response = MovieListDetail.GetMovieDetail.Response(movieDetail: .success(movieDetail))
    presenter.presentMovieDetail(response: response)

    // Then
    if let viewModel = movieDetailPresenterOutputsSpy.displayDataViewModel {
      
      switch viewModel.viewModel {
        
      case .success(let movieDetailViewModels):
        
        XCTAssertEqual(movieDetailViewModels.title, "test")
        XCTAssertEqual(movieDetailViewModels.popular, "1.00")
        XCTAssertEqual(movieDetailViewModels.overview, "test")
        XCTAssertEqual(movieDetailViewModels.category, "test")
        XCTAssertEqual(movieDetailViewModels.language, "test")
        XCTAssertEqual(movieDetailViewModels.rating, 0.0)
        XCTAssertEqual(movieDetailViewModels.movieImage?.absoluteString, "https://image.tmdb.org/t/p/original/test.jpg")
       
      default:
        XCTFail()
      }
    } else {
      XCTFail()
    }
  }
  
  func testPresentMovieDetailShouldAskViewControllerToDisplayDataWithFailureByInvalidData() {
    // Given
    presenter.viewController = movieDetailPresenterOutputsSpy
    // When
    let response = MovieListDetail.GetMovieDetail.Response(movieDetail: .failure(APIError.invalidData))
    presenter.presentMovieDetail(response: response)
    // Then
    XCTAssert(movieDetailPresenterOutputsSpy.displayDataCalled)
    if let viewModel = movieDetailPresenterOutputsSpy.displayDataViewModel {
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
  
  func testPresentGetMovieIdShouldAskViewControllerToDisplayGetMovieId() {
    // Given
    presenter.viewController = movieDetailPresenterOutputsSpy
    // When
    let response = MovieListDetail.getmoiveId.Response(movieId: 1)
    presenter.presentGetMovieId(respense: response)
    // Then
    XCTAssert(movieDetailPresenterOutputsSpy.displayGetMovieIdCalled) 
  }

}
