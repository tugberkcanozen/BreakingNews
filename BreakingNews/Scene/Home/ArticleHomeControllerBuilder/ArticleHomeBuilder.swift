//
//  ArticleHomeBuilder.swift
//  BreakingNews
//
//  Created by Tuğberk Can Özen on 29.06.2022.
//

import UIKit.UIViewController

// MARK: - Home Builder
final class HomeArticleBuilder {
    static func build() -> UIViewController {
        let service = Service()
        let viewModel: ArticleViewModel = ArticleViewModel(service: service)
        let vc = ArticleHomeController(viewModel: viewModel)
        return vc
    }
}
