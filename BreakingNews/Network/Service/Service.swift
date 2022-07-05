//
//  Service.swift
//  serviceManagerTest
//
//  Created by Tuğberk Can Özen on 28.06.2022.
//

import Alamofire

// MARK: - ServiceProtocol
protocol ServiceProtocol: AnyObject {
    func fetchArticles(onSuccess: @escaping (ArticleList?) -> Void, onError: @escaping (AFError) -> Void)
}

// MARK: - Services
final class Service: ServiceProtocol {

    func fetchArticles(onSuccess: @escaping (ArticleList?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Constant.Network.ServiceEndPoint.fetchArticles()) { (response: ArticleList) in
            onSuccess(response)
            
        } onError: { error in
            onError(error)
        }
    }

}
