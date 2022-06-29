//
//  ViewModel.swift
//  serviceManagerTest
//
//  Created by Tuğberk Can Özen on 28.06.2022.
//

import Foundation
import Alamofire
import Kingfisher
import UIKit

// MARK: - View Model Protocol
protocol ArticleViewModelProtocol {
    func fetchArticles(onSuccess: @escaping (ArticleList?) -> Void, onError: @escaping (AFError) -> Void)
    
    var articles: [Article] { get set }
    var searchData: [Article] { get set }
    var isSearch: Bool { get set }
    var delegate: ArticleOutPut? { get set }
    func searchedTitle(searchText: String?)
}

final class ArticleViewModel: ArticleViewModelProtocol {
    
    var delegate: ArticleOutPut?
    var articles = [Article]()
    var searchData = [Article]()
    var isSearch = Bool()
    
    var service: ServiceProtocol
    
    init(service: ServiceProtocol){
        self.service = service
    }
}

// MARK: - Search
extension ArticleViewModel {
    func searchedTitle(searchText: String?) {
        guard let searchText = searchText else { return }
        searchData = articles.filter({($0.title?.lowercased().contains(searchText.lowercased()))!})
    }
}

// MARK: - Service
extension ArticleViewModel {
    func fetchArticles(onSuccess: @escaping (ArticleList?) -> Void, onError: @escaping (AFError) -> Void) {
        service.fetchArticles { data in
            guard let model = data else { onSuccess(nil)
                return
            }
            onSuccess(model)
        } onError: { error in
            onError(error)
        }
    }
}
