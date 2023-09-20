//
//  TMMoviesListController.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 17/08/2023.
//  
//


import UIKit

// MARK: TMMoviesListController: BaseViewController

class TMMoviesListController: UIViewController {
    
    let MovieCellIdentifier = "TMMovieTableViewCell"

    // MARK: Properties
    var presenter: TMMoviesListPresenterInterface?
    private var isLoadingData = false
    var movies: [TMMovieUIModel] = []

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
}

// MARK: Lifecycle Methods
extension TMMoviesListController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        presenter?.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter?.viewDidDisappear(animated)
    }
}

// MARK: TMMoviesListViewInterface - Setup Methods
extension TMMoviesListController: TMMoviesListViewInterface {
    
    // Update  data source and reload the table view
    func updateMoviesList(_ movies: [TMMovieUIModel]) {
        self.isLoadingData = false
        self.movies.append(contentsOf: movies)

        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
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
        cell.movieNameLabel.text = movies[indexPath.row].title
        cell.movieProductionYearLabel.text = movies[indexPath.row].releaseDate
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
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        192
    }
}
