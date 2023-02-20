//
//  Network.swift
//  PetFinder
//
//  Created by Consultant on 1/19/23.
//

import Foundation
import Combine
import SwiftUI

struct Network {
    let decoder = JSONDecoder()
    
    func load<T: Decodable>(from urlRequest: URLRequest) -> AnyPublisher<T, NetworkErrors> {
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { error in NetworkErrors.error(error) }
            .flatMap{ data, response -> AnyPublisher<T, NetworkErrors> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: NetworkErrors.responseError).eraseToAnyPublisher()
                }
                
                if !(200...299).contains(response.statusCode) {
                    return Fail(error: NetworkErrors.badCode(response.statusCode)).eraseToAnyPublisher()
                }
                
                return Just(data)
                        .decode(type: T.self, decoder: decoder)
                        .mapError{_ in NetworkErrors.decodeError }
                        .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func load<T: Codable>(from urlRequest: URLRequest)  -> AnyPublisher<T, NetworkErrors> {
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { error in NetworkErrors.error(error) }
            .flatMap{  data, response -> AnyPublisher<T, NetworkErrors> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: NetworkErrors.responseError).eraseToAnyPublisher()
                }
                
                if !(200...299).contains(response.statusCode) {
                    return Fail(error: NetworkErrors.badCode(response.statusCode)).eraseToAnyPublisher()
                }
                
                return Just(data)
                        .decode(type: T.self, decoder: decoder)
                        .mapError{_ in NetworkErrors.decodeError }
                        .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func loadImage(_ urlString: String) -> AnyPublisher<UIImage?, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkErrors.urlError).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .mapError { error in NetworkErrors.error(error) }
            .tryMap{ data, response -> UIImage? in
                
                return UIImage(data: data)
            }
            .eraseToAnyPublisher()
    }
    
    func login() -> AnyPublisher<APIToken, NetworkErrors> {
        guard let url = URL(string: URLConsts.login) else {
            return Fail(error: NetworkErrors.urlError).eraseToAnyPublisher()
        }
        
        let parameters: [String: Any] = [
                "grant_type" : "client_credentials",
                "client_id" : Identifiers.key,
                "client_secret": Identifiers.secret
            ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                return  Fail(error: NetworkErrors.bodyParseError).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpBody = httpBody
        
        return load(from: urlRequest)
        
    }
}
