//
//  ArticleHomeController+Extension.swift
//  BreakingNews
//
//  Created by Tuğberk Can Özen on 28.06.2022.
//

import UIKit

extension UISearchController {
    
    func searchControllerUI() {
        searchBar.sizeToFit()
        loadViewIfNeeded()
        obscuresBackgroundDuringPresentation = false
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.tintColor = UIColor(.red)
        searchBar.searchTextField.textColor = .black
        searchBar.placeholder = "Search News"
    }
}
