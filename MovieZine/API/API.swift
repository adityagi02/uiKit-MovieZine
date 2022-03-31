//
//  API.swift
//  MovieZine
//
//  Created by Aditya Tyagi  on 25/03/22.
//

import Foundation
import Alamofire

let apiKey = "86bc758fa6b42bf3ec3433b90e5652c4"
private let baseURL = "https://api.themoviedb.org/3/movie/"
let posterURL = "https://image.tmdb.org/t/p/original"
let backdropURL = "https://image.tmdb.org/t/p/original"
private let coder = JSONDecoder()

class API {
    
    class func fetchTrendingMovies(_ page: Int, onSuccess: @escaping(Results) -> Void){
        let urlStr = "\(baseURL)now_playing?api_key=\(apiKey)"
        guard let url = URL(string: urlStr) else {
            fatalError("Unable to get URL")
        }
        AF.request(url).response { response in
            switch response.result {
            case.success(let data):
                guard let data = data else {
                    fatalError("Unable to parse data from API")
                }
                guard let results = try? coder.decode(Results.self, from: data) else {
                    fatalError("Unable to parse data from JSON")
                }
                DispatchQueue.main.async {
                    onSuccess(results)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
