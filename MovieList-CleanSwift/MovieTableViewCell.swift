//
//  MovieTableViewCell.swift
//  MovieList-CleanSwift
//
//  Created by Aksorn Khantasit on 23/9/2562 BE.
//  Copyright © 2562 Aksorn. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var popular: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    
    func setupUI(viewModel: MovieList.GetMovies.ViewModel.MovieViewModel){
       // backdropImage.image = viewModel.backdropImage
        title.text = viewModel.title
        popular.text = viewModel.popular
        rating.text = viewModel.rating
        
        
    }
    
}
