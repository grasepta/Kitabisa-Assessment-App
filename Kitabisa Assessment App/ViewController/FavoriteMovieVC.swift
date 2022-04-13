//
//  FavoriteMovieVC.swift
//  Kitabisa Assessment App
//
//  Created by Aldino Grasepta on 13/04/22.
//

import UIKit

class FavoriteMovieVC: UIViewController {
    
    var favoriteMovieVM = FavoriteMoviesViewModel()

    @IBOutlet weak var FavListTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
    }
    
    func setupFavListTV() {
        let nib = UINib(nibName: "MoviesTableViewCell", bundle: nil)
        FavListTV.register(nib, forCellReuseIdentifier: "MoviesTableViewCell")
        FavListTV.dataSource = self
        FavListTV.delegate = self
    }
    
    func commonInit() {
        setupFavListTV()
        setupListener()
        getData()
    }
    
    func setupListener() {
        
    }
    
    func getData() {
        favoriteMovieVM.getAllItems {
            self.FavListTV.reloadData()
        }
    }
    
    func navigateToMovieDetail(_ movieId: Int) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
        vc.selectedMovieId = movieId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FavoriteMovieVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovieVM.favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FavListTV.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        let selectedMovieId = favoriteMovieVM.favoriteMovies[indexPath.row].movieId
        cell.fetchMovieList(Int(selectedMovieId))
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 224
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMovieId = favoriteMovieVM.favoriteMovies[indexPath.row].movieId
        navigateToMovieDetail(Int(selectedMovieId))
    }
}
