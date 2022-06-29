//
//  ArticleDetailController+Extension.swift
//  BreakingNews
//
//  Created by Tuğberk Can Özen on 28.06.2022.
//

import UIKit
import Hero

extension UILabel {
    func detailTitle() {
        numberOfLines = 0
        font = .boldSystemFont(ofSize: 20)
        textAlignment = .center
        textColor = .black
        heroID = "titleLabel"
    }
    
    func detailOverView() {
        numberOfLines = 0
        textColor = .black
    }
}

extension UIImageView {
    func detailImageView() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 30
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        heroID = "imageView"
    }
}

extension UIButton {
    func detailButton() {
        setTitle("Visit the WebSite", for: .normal)
        titleLabel?.textColor = .white
        backgroundColor = .lightGray
        layer.cornerRadius = 12
        clipsToBounds = true
    }
}
