//
//  AnimalsNetwork.swift
//  PetFinder
//
//  Created by Consultant on 1/24/23.
//

import Foundation
import Combine

struct AnimalsNetwork {
    
    let network: Network
    
    init(network: Network = Network()){
        self.network = network
    }
    
    func getAnimalAPI(_ apiToken: APIToken) -> AnyPublisher<AnimalAPI, NetworkErrors> {
        guard let url = URL(string: URLConsts.animals) else {
            return Fail(error: NetworkErrors.urlError).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer " + apiToken.token, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return network.load(from: request)
    }
    
    func getAnimalList() -> AnyPublisher<AnimalAPI, NetworkErrors> {
        network.login().flatMap(getAnimalAPI).eraseToAnyPublisher()
    }
    
}
