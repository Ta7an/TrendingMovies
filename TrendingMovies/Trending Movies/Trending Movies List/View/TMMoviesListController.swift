//
//  TMMoviesListController.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 17/08/2023.
//  
//


import UIKit
import SDWebImage

// MARK: TMMoviesListController: BaseViewController

class TMMoviesListController: UIViewController {
    
    let MovieCellIdentifier = "TMMovieTableViewCell"

    // MARK: Properties
    var presenter: TMMoviesListPresenterInterface?
    private var isLoadingData = false
    var movies: [TMMovieUIModel] = []
    var imagesConfig: TMImagesConfig?
    
    // MARK: Views
    @IBOutlet weak var tableView: UITableView!
    
    // Main loading indicator
    let mainLoadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    // Bottom loading indicator
    let bottomLoadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()

}

// MARK: Lifecycle Methods
extension TMMoviesListController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add main loading indicator to the view
        mainLoadingIndicator.center = view.center
        view.addSubview(mainLoadingIndicator)
        
        // Initialize and configure the loading indicators
        configureMainLoadingIndicator()
        configureBottomLoadingIndicator()

        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter?.viewWillAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter?.viewDidDisappear(animated)
    }
    
    // MARK: - UI Configuration

    private func configureMainLoadingIndicator() {
        mainLoadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        mainLoadingIndicator.hidesWhenStopped = true
        view.addSubview(mainLoadingIndicator)
        
        // Center the main loading indicator
        mainLoadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainLoadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func configureBottomLoadingIndicator() {
        // Create a container view for the loading indicator
        let container = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44))
        
        // Center the loading indicator in the container
        bottomLoadingIndicator.center = CGPoint(x: container.bounds.midX, y: container.bounds.midY)
        
        // Add the loading indicator to the container
        container.addSubview(bottomLoadingIndicator)
        
        // Set the container as the table view's footer
        tableView.tableFooterView = container
    }

    func showMainLoadingIndicator() {
        mainLoadingIndicator.startAnimating()
        view.isUserInteractionEnabled = false // Disable user interaction during loading if needed
    }

    func hideMainLoadingIndicator() {
        mainLoadingIndicator.stopAnimating()
        view.isUserInteractionEnabled = true // Re-enable user interaction
    }

    func showBottomLoadingIndicator() {
        configureBottomLoadingIndicator()
        bottomLoadingIndicator.startAnimating()
    }

    func hideBottomLoadingIndicator() {
        bottomLoadingIndicator.stopAnimating()
    }
}

// MARK: TMMoviesListViewInterface - Setup Methods
extension TMMoviesListController: TMMoviesListViewInterface, ErrorHandling {
    
    // Update  data source and reload the table view
    fileprivate func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func updateMoviesList(_ movies: [TMMovieUIModel]) {
        self.isLoadingData = false
        self.movies.append(contentsOf: movies)

        reloadTableView()
    }
    
    func updateTMDBImagesConfig(_ config: TMImagesConfig) {
        self.imagesConfig = config
        reloadTableView()
    }

    func handleAPIError(_ errorMessage: String) {
        isLoadingData = false
        
        // Show an alert with the error message
        showAlert(message: errorMessage)
    }
}

// MARK: TableView Delegate and DataSource Methods
extension TMMoviesListController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCellIdentifier, for: indexPath) as? TMMovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = movies[indexPath.row]
        cell.movieNameLabel.text = movie.title
        cell.movieProductionYearLabel.text = movie.releaseDate
        cell.movieBannerImageView.sd_setImage(with: movie.posterURL(using: imagesConfig))
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard !isLoadingData else { return }
        
        // Get the index path of the last cell in the table view
        let lastIndexPath = IndexPath(row: movies.count - 1, section: 0)
        
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last,
           lastVisibleIndexPath == lastIndexPath {
            isLoadingData = true
            presenter?.fetchMovies()
        }
        
        for indexPath in indexPaths {
            if indexPath.row < movies.count {
                let movie = movies[indexPath.row]
                SDWebImageManager.shared.loadImage(with: movie.posterURL(using: imagesConfig), options: [], progress: nil) {_,_,_,_,_,_ in }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        192
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectMovie(movies[indexPath.row])
    }
}
