//
//  Model.swift
//  serviceManagerTest
//
//  Created by Tuğberk Can Özen on 28.06.2022.
//

import UIKit

import Foundation

// MARK: - Welcome
struct ArticleList: Codable {
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let author: String?
    let title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    let content: String?
}
