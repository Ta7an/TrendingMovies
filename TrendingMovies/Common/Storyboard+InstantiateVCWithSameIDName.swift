//
//  Storyboard+InstantiateVCWithSameIDName.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 23/09/2023.
//

import UIKit

extension UIStoryboard {

    func instantiateViewController<T: UIViewController>(ofType _: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)

        return instantiateViewController(withIdentifier: identifier) as! T
    }

}
