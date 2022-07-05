//
//  ServiceManager.swift
//  serviceManagerTest
//
//  Created by Tuğberk Can Özen on 22.06.2022.
//

import Alamofire

// MARK: - Generic Service Manager
final class ServiceManager {
    static let shared: ServiceManager = ServiceManager()
}

extension ServiceManager {
    func fetch<T>(path: String, onSuccess: @escaping (T) -> (), onError: (AFError) ->()) where T: Codable {
        
        AF.request(path, encoding: JSONEncoding.default).validate().responseDecodable(of: T.self) { response in
            
            guard let model = response.value else { print( response.error as Any ); return }
            onSuccess(model)
        }
    }
}
