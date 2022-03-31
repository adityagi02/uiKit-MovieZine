//
//  UnpopularMovieCollectionViewCell.swift
//  MovieZine
//
//  Created by Aditya Tyagi  on 27/03/22.
//

import UIKit
import Kingfisher

class UnpopularMovieCollectionViewCell: UICollectionViewCell {
    
    var Unpopularmovie: Movie? {
        didSet{
            if let movie = Unpopularmovie {
                moviePoster?.kf.setImage(with: movie.backdropPath.imageUrl)
                unpopularMovieTitle.text = movie.originalTitle
            }
        }
    }
    
    @IBOutlet weak var unpopularMovieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView?
    
}

extension String{
    var imageUrl: URL? {
        return URL(string: "\(backdropURL)\(self)")
    }
}

