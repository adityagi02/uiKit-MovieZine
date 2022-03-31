//
//  Results.swift
//  MovieZine
//
//  Created by Aditya Tyagi  on 25/03/22.
//

import Foundation

struct Results: Codable {
    let dates: Dates
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Dates: Codable {
    let maximum, minimum: String
}

