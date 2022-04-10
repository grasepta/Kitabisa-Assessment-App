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
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            print("Got data: \(data)")
            
            var result: MoviesResponse?
            do {
                try result = JSONDecoder().decode(MoviesResponse.self, from: data)
            } catch {
                print("Failed to Decode with error: \(error.localizedDescription)")
            }
            guard let final = result?.movies else { return }
            print(final)
            self.bindData(final, preference)
        }
        task.resume()
    }
}
