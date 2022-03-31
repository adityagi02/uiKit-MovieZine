//
//  ViewController.swift
//  MovieZine
//
//  Created by Aditya Tyagi  on 25/03/22.
//

import UIKit

private let identifier = "MovieCell"


class TrendingMoviesViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
     var movies: [Movie]
     var page: Int = 1
    private var totalPages: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = (view.frame.size.width-20)/3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: 190)
        fetch()
        }
    
     func fetch(_ page: Int = 1) {
        API.fetchTrendingMovies(page) { data in
            self.totalPages = data.totalPages
        self.movies = data.results
        self.collectionView.reloadData()
       }
    }
    
     func loadMoreData(){
        if page < totalPages {
            page += 1
            OperationQueue.main.addOperation {
                API.fetchTrendingMovies(self.page) { data in
                    self.movies! += data.results
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension TrendingMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MovieCollectionViewCell
        cell1.movie = movies?[indexPath.item]
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "UnpopularMovieCell", for: indexPath) as! UnpopularMovieCollectionViewCell
        cell2.Unpopularmovie = movies?[indexPath.item]
        if cell1.movie!.voteAverage < 7 {
            return cell2
        }else {
            return cell1
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let count = movies?.count else { fatalError() }
        if indexPath.item == count - 1 {
            self.loadMoreData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tmovieTitle = movies.
        if segue.identifier == "showMovieDetail"{
            guard let sendTomovieDetailController = segue.destination as? DetailViewController else {
              return
            }
            sendTomovieDetailController.title = tmovieTitle
            sendTomovieDetailController.videoPoster = movie?.backdropPath
        }
    }
}
