//
//  MovieDetailViewModel.swift
//  Kitabisa Assessment App
//
//  Created by Aldino Grasepta on 13/04/22.
//

import Foundation

class MovieDetailViewModel {
    var movieDetail: Observable<MoviesDetailModel> = Observable(nil)
    var reviewList: Observable<[ReviewModel]> = Observable([])
    
    func getMoviesData(_ id: Int) {
        let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=02ebdf68252e7814b15008060bc959c5"
        NetworkManager().fetchData(url: urlString) { (data: MoviesDetailModel?) in
            self.movieDetail.value = data
        }
    }
    
    func getReviewssData(_ id: Int) {
        let urlString = "https://api.themoviedb.org/3/movie/\(id)/reviews?api_key=02ebdf68252e7814b15008060bc959c5&page=1"
        NetworkManager().fetchData(url: urlString) { (data: ReviewsResponse?) in
            self.reviewList.value = data?.reviews
        }
    }
}
