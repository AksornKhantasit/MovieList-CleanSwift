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
  
  // MARK: - Event handling
  
  func getcosmos()  {
    cosmos.settings.minTouchRating = 0
    cosmos.settings.fillMode = .half
    cosmos.didTouchCosmos = { rat in
      //      self.rating = rat * 2
      //      print("Rating: \(self.rating)")
      self.setRating(rating: rat * 2)
      self.delegate?.reloadTableView()
    }
  }
  
  func setupData() {
    let request = MovieListDetail.GetMovieDetail.Request()
    interactor.getMovieDetail(request: request)
  }
  
  func setRating(rating: Double) {
    let request = MovieListDetail.SetRating.Request(rating: rating)
    interactor.setRating(request: request)
  }
  
  // MARK: - Display logic
  
  func displayData(viewModel: MovieListDetail.GetMovieDetail.ViewModel) {
    switch viewModel.viewModel {
    case .success(let data):
      movieImage.kf.setImage(with: data.movieImage)
      titleName.text = data.title
      popular.text = data.popular
      overview.text = data.overview
      category.text = data.category
      language.text = data.language
      cosmos.rating = data.rating
    case .failure(let error):
      let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
      let action = UIAlertAction(title: "OK", style: .destructive)
      alert.addAction(action)
      present(alert, animated: true)
    }
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
