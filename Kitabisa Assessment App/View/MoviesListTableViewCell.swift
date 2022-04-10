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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindData(_ titleString:String, _ releaseDateString:String, _ overviewString:String) {
        titleLabel.text = titleString
        releaseDateLabel.text = releaseDateString
        overviewLabel.text = overviewString
    }
}
