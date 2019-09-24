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
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testSomething() {
    // Given

    // When

    // Then
  }
}
