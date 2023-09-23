//
//  UIViewController+ErrorHandling.swift
//  TrendingMovies
//
//  Created by Mohamed Eltahan on 23/09/2023.
//

import UIKit

extension UIViewController {    
    // Helper function to display an alert
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}
