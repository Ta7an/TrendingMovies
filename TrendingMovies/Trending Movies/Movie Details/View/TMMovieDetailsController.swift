//
//  TMMovieDetailsController.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 23/09/2023.
//  
//

import UIKit
import SDWebImage

// MARK: TMMovieDetailsController: BaseViewController

class TMMovieDetailsController: UIViewController {
    // MARK: Properties

    var presenter: TMMovieDetailsPresenterInterface?
    // MARK: Outlets
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var productionYear: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
}

// MARK: Lifecycle Methods

extension TMMovieDetailsController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.presenter?.viewDidDisappear(animated)
    }
}

// MARK: TMMovieDetailsViewInterface - Setup Methods

extension TMMovieDetailsController: TMMovieDetailsViewInterface {
    func setupUI(with movie: TMMovieUIModel) {
        movieName.text = movie.title
        movieDescription.text = movie.overview
        moviePosterImageView.sd_setImage(with: presenter?.moviePosterURL)
    }
}
