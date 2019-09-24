//
//  MovieListRouter.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 22/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

import UIKit

protocol MovieListRouterInput {
  func navigateToMovieDetail()
}

class MovieListRouter: MovieListRouterInput {
  weak var viewController: MovieListViewController!
  
  // MARK: - Navigation
  
  func navigateToMovieDetail() {
    viewController.performSegue(withIdentifier: "ShowDetail", sender: nil)
  }
  // MARK: - Communication
  
  func passDataToNextScene(segue: UIStoryboardSegue) {
    if segue.identifier == "ShowDetail" {
      passDataToMovieDetailScene(segue: segue)
    }
  }
  
  func passDataToMovieDetailScene(segue: UIStoryboardSegue) {
    guard let movieDetailViewController = segue.destination as? MovieDetailViewController, let id = viewController.interactor.selectedID else {
      return
    }
    movieDetailViewController.interactor.id = id
    movieDetailViewController.delegate = viewController
  }
}

