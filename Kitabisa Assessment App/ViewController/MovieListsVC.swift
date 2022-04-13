//
//  ViewController.swift
//  Kitabisa Assessment App
//
//  Created by Aldino Grasepta on 10/04/22.
//

import UIKit

class MovieListsVC: UIViewController {

    var preferencesVM = PreferencesViewModel()
    var moviesListVM = MoviesListViewModel()
    
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
        let nib = UINib(nibName: "MoviesTableViewCell", bundle: nil)
        movieListTV.register(nib, forCellReuseIdentifier: "MoviesTableViewCell")
        movieListTV.dataSource = self
        movieListTV.delegate = self
    }
    
    func setupListener() {
        moviesListVM.topRatedMovies.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.movieListTV.reloadData()
            }
        }
        moviesListVM.popularMovies.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.movieListTV.reloadData()
            }
        }
        moviesListVM.nowPlayingMovies.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.movieListTV.reloadData()
            }
        }
    }
    
    func getData() {
        moviesListVM.getMovies(.popular)
        moviesListVM.getMovies(.topRated)
        moviesListVM.getMovies(.nowPlaying)
    }
    
    func navigateToMovieDetail(_ movieId: Int) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
        vc.selectedMovieId = movieId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToFavoriteMovie() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FavoriteMovieVC") as! FavoriteMovieVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func favButtonPressed(_ sender: Any) {
        navigateToFavoriteMovie()
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
            return moviesListVM.popularMovies.value?.count ?? 0
        case 1:
            return moviesListVM.topRatedMovies.value?.count ?? 0
        case 2:
            return moviesListVM.nowPlayingMovies.value?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieListTV.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        var movieData: MovieModel? = nil
        switch indexPath.section {
        case 0:
            movieData = moviesListVM.popularMovies.value?[indexPath.row]
        case 1:
            movieData = moviesListVM.topRatedMovies.value?[indexPath.row]
        case 2:
            movieData = moviesListVM.nowPlayingMovies.value?[indexPath.row]
        default:
            cell.bindData("Not Found", "Not Found", "Not Found", "")
        }
        cell.bindData(
            movieData?.title ?? "Not Found",
            movieData?.releaseDate ?? "Not Found",
            movieData?.overview ?? "Not Found",
            movieData?.posterPath ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 224
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var movieData: MovieModel? = nil
        switch indexPath.section {
        case 0:
            movieData = moviesListVM.popularMovies.value?[indexPath.row]
        case 1:
            movieData = moviesListVM.topRatedMovies.value?[indexPath.row]
        case 2:
            movieData = moviesListVM.nowPlayingMovies.value?[indexPath.row]
        default:
            break
        }
        if let selectedMovieId = movieData?.id {
            navigateToMovieDetail(selectedMovieId)
        } else {
            print("cannot found movie detail")
        }
    }
}
