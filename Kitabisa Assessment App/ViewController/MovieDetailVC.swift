//
//  MovieDetailViewController.swift
//  Kitabisa Assessment App
//
//  Created by Aldino Grasepta on 13/04/22.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    var selectedMovieId: Int?
    var movieDetailVM = MovieDetailViewModel()
    var favoriteMovieVM = FavoriteMoviesViewModel()
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var reviewTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    func commonInit() {
        setupReviewTableView()
        setupListener()
        getData()
    }
    
    func setupListener() {
        movieDetailVM.movieDetail.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.bindData()
            }
        }
        movieDetailVM.reviewList.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.reviewTableView.reloadData()
            }
        }
    }
    
    func getData() {
        movieDetailVM.getMoviesData(selectedMovieId ?? 00)
        movieDetailVM.getReviewssData(selectedMovieId ?? 00)
    }
    
    func bindData() {
        let movieDetailData = self.movieDetailVM.movieDetail.value
        self.titleLabel.text = movieDetailData?.title
        self.releaseDateLabel.text = movieDetailData?.releaseDate
        self.overviewLabel.text = movieDetailData?.overview
        fetchImage(movieDetailData?.posterPath)
    }
    
    func fetchImage(_ posterPath: String?) {
        let url = "https://image.tmdb.org/t/p/w500/\(posterPath ?? "")"
        NetworkManager().fetchData(url: url) { result in
            DispatchQueue.main.async {
                let image = UIImage(data: result!)
                self.posterImageView.image = image
            }
        }
    }
    
    func setupReviewTableView() {
        reviewTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        reviewTableView.dataSource = self
        reviewTableView.delegate = self
    }
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        favoriteMovieVM.toggleFavorite(selectedMovieId!)
    }
}

extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDetailVM.reviewList.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")


        cell.textLabel?.text = movieDetailVM.reviewList.value?[indexPath.row].content
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "author: \(movieDetailVM.reviewList.value?[indexPath.row].author ?? "")"
        return cell
    }
}
