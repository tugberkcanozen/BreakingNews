//
//  Cell+HomeController.swift
//  BreakingNews
//
//  Created by Tuğberk Can Özen on 28.06.2022.
//

import Foundation
import UIKit
import Hero

extension UILabel {
    func homeCellLabel() {
        numberOfLines = 2
        textColor = .systemIndigo
        font = UIFont.boldSystemFont(ofSize: 20)
        heroID = "titleLabel"
    }
    
    func homeCellContent() {
        numberOfLines = 5
    }
}

extension UIImageView {
    func homeCellImage() {
        layer.cornerRadius = 12
        clipsToBounds = true
        heroID = "imageView"
    }
}
