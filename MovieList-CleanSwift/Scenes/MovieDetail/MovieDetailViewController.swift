//
//  MovieDetailViewController.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 23/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

import UIKit
import Cosmos
import Kingfisher

protocol MovieDetailViewControllerInterface: class {
  func displayData(viewModel: MovieListDetail.GetMovieDetail.ViewModel)
}
protocol ReloadTableViewDelegate: class {
  func reloadTableView()
}

class MovieDetailViewController: UIViewController, MovieDetailViewControllerInterface {
  var interactor: MovieDetailInteractorInterface!
  var router: MovieDetailRouter!
  var rating: Double?
  var delegate: ReloadTableViewDelegate?

  @IBOutlet weak var movieImage: UIImageView!
  @IBOutlet weak var titleName: UILabel!
  @IBOutlet weak var cosmos: CosmosView!
  @IBOutlet weak var popular: UILabel!
  @IBOutlet weak var overview: UILabel!
  @IBOutlet weak var category: UILabel!
  @IBOutlet weak var language: UILabel!
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  // MARK: - Configuration
  
  private func configure(viewController: MovieDetailViewController) {
    let router = MovieDetailRouter()
    router.viewController = viewController
    
    let presenter = MovieDetailPresenter()
    presenter.viewController = viewController
    
    let interactor = MovieDetailInteractor()
    interactor.presenter = presenter
    interactor.worker = MovieDetailWorker(store: MovieDetailStore())
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupData()
    getcosmos()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    setRating()
    delegate?.reloadTableView()
  }
  
  // MARK: - Event handling
  
  func getcosmos()  {
    cosmos.settings.minTouchRating = 0
    cosmos.settings.fillMode = .half
    cosmos.didTouchCosmos = { rat in
      self.rating = rat * 2
      print("Rating: \(self.rating)")
    }
  }
  
  func setupData() {
    let request = MovieListDetail.GetMovieDetail.Request()
    interactor.getMovieDetail(request: request)
  }
  
  func setRating() {
    if let rating = rating {
      let request = MovieListDetail.SetRating.Request(rating: rating)
      interactor.setRating(request: request)
    }
  }
  
  // MARK: - Display logic
  
  func displayData(viewModel: MovieListDetail.GetMovieDetail.ViewModel) {
    let baseURL = "https://image.tmdb.org/t/p/original"
    let posterPath = viewModel.movieImage
    if let posterPath = posterPath {
      let url = URL(string: "\(baseURL)\(posterPath)")
      movieImage.kf.setImage(with: url)
    }
    titleName.text = viewModel.title
    popular.text = viewModel.popular
    overview.text = viewModel.overview
    category.text = viewModel.category
    language.text = viewModel.language
    cosmos.rating = viewModel.rating    
  }
  
  // MARK: - Router
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }
  
  @IBAction func unwindToMovieDetailViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}
