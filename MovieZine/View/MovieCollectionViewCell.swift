//
//  MovieCollectionViewCell.swift
//  MovieZine
//
//  Created by Aditya Tyagi  on 25/03/22.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    var movie: Movie? {
        didSet{
            if let movie = movie {
                    movieImage.kf.setImage(with: movie.backdropPath.imageUrl)
            }
        }
    }
    
    @IBOutlet private weak var movieImage: UIImageView!
}


extension String{
    var backdropUrl: URL? {
        return URL(string: "\(posterURL)\(self)")
    }
}
