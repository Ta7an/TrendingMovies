//
//  TrendingMoviesViewController.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 17/08/2023.
//

import UIKit

class TrendingMoviesViewController: UIViewController {
    
    let MovieCellIdentifier = "TMMovieTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension TrendingMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCellIdentifier, for: indexPath) as? TMMovieTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    
}
