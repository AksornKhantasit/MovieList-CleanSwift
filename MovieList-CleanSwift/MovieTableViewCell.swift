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
        rating.text = viewModel.rating
        
        let baseURL = "https://image.tmdb.org/t/p/original"
        let posterPath = viewModel.movieImage
        let backdropPath = viewModel.backdropImage
        if let posterPath = posterPath {
            let url = URL(string: "\(baseURL)\(posterPath)")
            movieImage.kf.setImage(with: url)
        }
        if let backdropPath = backdropPath {
            let url = URL(string: "\(baseURL)\(backdropPath)")
            backdropImage.kf.setImage(with: url)
        }
        
    }
    
}
