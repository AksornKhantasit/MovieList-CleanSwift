//
//  MovieTableViewCell.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 23/9/2562 BE.
//  Copyright © 2562 Aksorn. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var popular: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    
  func setupUI(viewModel: MovieList.GetMovies.ViewModel.MovieViewModel){
    
    title.text = viewModel.title
    popular.text = viewModel.popular
    //rating.text = viewModel.rating
    let getavg = UserDefaults.standard.double(forKey: "avg\(viewModel.id)") 
    if getavg == 0.0 {
      rating.text = String(viewModel.rating)
    }
    else {
      rating.text = String(format: "%.1f", getavg )
    }
    movieImage.kf.setImage(with: viewModel.movieImage)
    backdropImage.kf.setImage(with: viewModel.backdropImage)
  }
}
