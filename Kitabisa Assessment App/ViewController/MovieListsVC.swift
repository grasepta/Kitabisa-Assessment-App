//
//  ViewController.swift
//  Kitabisa Assessment App
//
//  Created by Aldino Grasepta on 10/04/22.
//

import UIKit

class MovieListsVC: UIViewController {

    var preferencesVM = PreferencesViewModel()
    var moviesVM = MoviesViewModel()
    
    @IBOutlet weak var movieListTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    func commonInit() {
        setupMovieListTV()
        setupListener()
        getData()
    }
    
    func setupMovieListTV() {
        
        movieListTV.dataSource = self
        movieListTV.delegate = self
    }
    
    func setupListener() {
        moviesVM.topRatedMovies.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.movieListTV.reloadData()
            }
        }
        moviesVM.popularMovies.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.movieListTV.reloadData()
            }
        }
        moviesVM.nowPlayingMovies.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.movieListTV.reloadData()
            }
        }
    }
    
    func getData() {
        moviesVM.getMovies(.popular)
        moviesVM.getMovies(.topRated)
        moviesVM.getMovies(.nowPlaying)
    }
}

extension MovieListsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return preferencesVM.preferences.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return preferencesVM.preferences[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return moviesVM.popularMovies.value?.count ?? 0
        case 1:
            return moviesVM.topRatedMovies.value?.count ?? 0
        case 2:
            return moviesVM.nowPlayingMovies.value?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieListTV.dequeueReusableCell(withIdentifier: "MoviesListCell", for: indexPath) as! MoviesListTableViewCell
        var movieData: MovieModel? = nil
        switch indexPath.section {
        case 0:
            movieData = moviesVM.popularMovies.value?[indexPath.row]
        case 1:
            movieData = moviesVM.topRatedMovies.value?[indexPath.row]
        case 2:
            movieData = moviesVM.nowPlayingMovies.value?[indexPath.row]
        default:
            cell.bindData("Not Found", "Not Found", "Not Found")
        }
        cell.bindData(movieData?.title ?? "Not Found", movieData?.releaseDate ?? "Not Found", movieData?.overview ?? "Not Found")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 224
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
