//
//  MovieDetailRouter.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 23/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

import UIKit

protocol MovieDetailRouterInput {
  func navigateToSomewhere()
}

class MovieDetailRouter: MovieDetailRouterInput {
  weak var viewController: MovieDetailViewController!

  // MARK: - Navigation

  func navigateToSomewhere() {
  }

  // MARK: - Communication

  func passDataToNextScene(segue: UIStoryboardSegue) {
    if segue.identifier == "ShowSomewhereScene" {
      passDataToSomewhereScene(segue: segue)
    }
  }

  func passDataToSomewhereScene(segue: UIStoryboardSegue) {
  }
}
