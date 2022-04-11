//
//  MoviesViewModel.swift
//  Kitabisa Assessment App
//
//  Created by Aldino Grasepta on 10/04/22.
//

import Foundation

class MoviesViewModel {
    var popularMovies: Observable<[MovieModel]> = Observable([])
    var topRatedMovies: Observable<[MovieModel]> = Observable([])
    var nowPlayingMovies: Observable<[MovieModel]> = Observable([])
    
    enum whichPreference {
    case popular
    case topRated
    case nowPlaying
    }
    
    func getMovies(_ preference: whichPreference) {
        var urlString = ""
        switch preference {
        case .popular:
            urlString = "https://api.themoviedb.org/3/movie/popular?api_key=02ebdf68252e7814b15008060bc959c5&page=1"
        case .topRated:
            urlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=02ebdf68252e7814b15008060bc959c5&page=1"
        case .nowPlaying:
            urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=02ebdf68252e7814b15008060bc959c5&page=1"
        }
        getMoviesData(urlString, preference)
    }
    
    func bindData(_ movieModel: [MovieModel], _ preference: whichPreference) {
        switch preference {
        case .popular:
            popularMovies.value = movieModel
        case .topRated:
            topRatedMovies.value = movieModel
        case .nowPlaying:
            nowPlayingMovies.value = movieModel
        }
    }
    
    private func getMoviesData(_ urlString: String, _ preference: whichPreference) {
        NetworkManager().fetchData(url: urlString) { (data: MoviesResponse?) in
            self.bindData(data?.movies ?? [], preference)
        }
    }
}
