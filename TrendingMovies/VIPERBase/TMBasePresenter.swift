//
//  TMBasePresenter.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 14/09/2023.
//

import Foundation

protocol TMBasePresenter: AnyObject {
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
}

extension TMBasePresenter {
    func viewDidLoad() {}
    func viewDidDisappear(_ animated: Bool) {}
    func viewWillAppear(_ animated: Bool) {}
    func viewWillDisappear(_ animated: Bool) {}
}
