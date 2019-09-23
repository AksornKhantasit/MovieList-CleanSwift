//
//  MovieListViewController.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 22/9/2562 BE.
//  Copyright (c) 2562 Aksorn. All rights reserved.
//

import UIKit

protocol MovieListViewControllerInterface: class {
  func displayMovies(viewModel: MovieList.GetMovies.ViewModel)
}

class MovieListViewController: UIViewController, MovieListViewControllerInterface {
  var interactor: MovieListInteractorInterface!
  //var router: MovieListRouter!

    @IBOutlet weak var tableView: UITableView!
    
  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

  // MARK: - Configuration

  private func configure(viewController: MovieListViewController) {
//    let router = MovieListRouter()
//    router.viewController = viewController

    let presenter = MovieListPresenter()
    presenter.viewController = viewController

    let interactor = MovieListInteractor()
    interactor.presenter = presenter
    interactor.worker = MovieListWorker(store: MovieListStore())

    viewController.interactor = interactor
//    viewController.router = router
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    let bundle = Bundle(for: MovieTableViewCell.self)
    let nib = UINib(nibName: "MovieTableViewCell", bundle: bundle)
    tableView.register(nib, forCellReuseIdentifier: "MovieTableViewCell")
    getMovies()
  }

  // MARK: - Event handling
    func getMovies() {
        //loadingView.isHidden = false
        let request = MovieList.GetMovies.Request()
        interactor.getMovies(request: request)
    }
    
  // MARK: - Display logic
    
    var movieViewModels: [MovieList.GetMovies.ViewModel.MovieViewModel] = []

  func displayMovies(viewModel: MovieList.GetMovies.ViewModel) {
    // NOTE: Display the result from the Presenter
//     loadingView.isHidden = true
    movieViewModels.append(contentsOf: viewModel.movieViewModels)
    tableView.reloadData()
  }

  // MARK: - Router
/*
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }

  @IBAction func unwindToMovieListViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
 */
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return movieViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let viewModel = movieViewModels[indexPath.row]
        cell.setupUI(viewModel: viewModel)
        return cell
    }
}
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if movies.indices.contains(indexPath.row) {
//            let movieItem = movies[indexPath.row]
//            self.performSegue(withIdentifier: "showDetail", sender: movieItem)
//        }
    }
}
