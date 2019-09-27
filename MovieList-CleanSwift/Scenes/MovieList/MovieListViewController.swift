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
  func displaySelectedIndex(viewModel: MovieList.SetSelectedIndex.ViewModel)
  func displaySort(viewModel: MovieList.SetSort.ViewModel)
  func displayPullRefresh(viewModel: MovieList.PullRefresh.ViewModel)
  func displayReloadCell(viewModel: MovieList.ReloadCell.ViewModel)
}

class MovieListViewController: UIViewController, MovieListViewControllerInterface {

  var interactor: MovieListInteractorInterface!
  var router: MovieListRouter!
  var refreshControl = UIRefreshControl()
 
  @IBOutlet weak var loadingView: UIView!
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  // MARK: - Configuration
  
  private func configure(viewController: MovieListViewController) {
    let router = MovieListRouter()
    router.viewController = viewController
    
    let presenter = MovieListPresenter()
    presenter.viewController = viewController
    
    let interactor = MovieListInteractor()
    interactor.presenter = presenter
    interactor.worker = MovieListWorker(store: MovieListStore())
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let bundle = Bundle(for: MovieTableViewCell.self)
    let nib = UINib(nibName: "MovieTableViewCell", bundle: bundle)
    tableView.register(nib, forCellReuseIdentifier: "MovieTableViewCell")
    
    getMovies()
    
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refreshControl.addTarget(self, action: #selector(refresh(sender: )), for: UIControl.Event.valueChanged)
    tableView.addSubview(refreshControl)
    
  }
  @objc func refresh(sender:AnyObject) {
    let request = MovieList.PullRefresh.Request()
    interactor.pullRefresh(request: request)
  }
  
  @IBAction func sort(_ sender: Any) {
    showAlert()
  }
  // MARK: - Event handling
  func getMovies() {
    loadingView.isHidden = false
    let request = MovieList.GetMovies.Request()
    interactor.getMovies(request: request)
  }
  
  func showAlert() {
    let alert = UIAlertController(title: "Sort", message: "you want to sort by...", preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "ASC", style: .default, handler: { (_) in
      let request = MovieList.SetSort.Request(sortBy: .asc)
      self.interactor.setSort(request: request)
    }))
    
    alert.addAction(UIAlertAction(title: "DESC", style: .default, handler: { (_) in
      let request = MovieList.SetSort.Request(sortBy: .desc)
      self.interactor.setSort(request: request)
    }))
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (_) in
      print("You've pressed the Cancel")
    }))
    self.present(alert, animated: true, completion: nil)
  }
  
  // MARK: - Display logic
  
  var movieViewModels: [MovieList.MovieViewModel] = []
  
  func displayMovies(viewModel: MovieList.GetMovies.ViewModel) {
    switch viewModel.viewModel {
    case .success(let data):
      movieViewModels = data
      loadingView.isHidden = true
      tableView.reloadData()
    case .failure(let error):
      print(error)
      let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
      let action = UIAlertAction(title: "OK", style: .destructive)
      alert.addAction(action)
      loadingView.isHidden = true
      present(alert, animated: true)
    }
  }
  
  func displaySelectedIndex(viewModel: MovieList.SetSelectedIndex.ViewModel) {
    router.navigateToMovieDetail()
  }
  
  func displaySort(viewModel: MovieList.SetSort.ViewModel) {
    getMovies()
  }
  
  func displayPullRefresh(viewModel: MovieList.PullRefresh.ViewModel) {
    getMovies()
  }
  
  func displayReloadCell(viewModel: MovieList.ReloadCell.ViewModel) {
    for (index , value) in movieViewModels.enumerated() {
      if viewModel.viewModel.id == value.id {
        movieViewModels[index] = viewModel.viewModel
        tableView.reloadData()
      }
    }
  }
  
  
  
  // MARK: - Router
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }
  
  @IBAction func unwindToMovieListViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    if indexPath.row == movieViewModels.count - 1 && loadingView.isHidden {
      getMovies()
    }
    else if(indexPath.row == 1 && loadingView.isHidden) {
      refreshControl.endRefreshing()
    }
  }
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
    let id = movieViewModels[indexPath.row].id
    let request = MovieList.SetSelectedIndex.Request(id: id)
    interactor.setSelectedID(request: request)
    
  }
}

extension MovieListViewController : ReloadTableViewDelegate {
  func reloadTableView(movieId: Int) {
       let request = MovieList.ReloadCell.Request(movieId: movieId)
       interactor.reloadCell(request: request)
  }
}
