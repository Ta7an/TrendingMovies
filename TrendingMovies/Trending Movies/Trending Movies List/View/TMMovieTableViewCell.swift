//
//  MovieTableViewCell.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 17/08/2023.
//

import UIKit

class TMMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieProductionYearLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieBannerImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
