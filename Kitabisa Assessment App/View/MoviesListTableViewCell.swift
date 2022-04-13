//
//  MoviesListTableViewCell.swift
//  Kitabisa Assessment App
//
//  Created by Aldino Grasepta on 10/04/22.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindData(_ titleString:String, _ releaseDateString:String, _ overviewString:String, _ posterUrl:String) {
        titleLabel.text = titleString
        releaseDateLabel.text = releaseDateString
        overviewLabel.text = overviewString
        fetchImage(posterUrl)
    }
    
    func fetchImage(_ posterPath: String) {
        let url = "https://image.tmdb.org/t/p/w500/\(posterPath)"
        NetworkManager().fetchData(url: url) { result in
            DispatchQueue.main.async {
                let image = UIImage(data: result!)
                self.posterImageView.image = image
            }
        }
    }
}
