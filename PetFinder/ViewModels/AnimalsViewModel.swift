//
//  AnimalsViewModel.swift
//  PetFinder
//
//  Created by Consultant on 1/19/23.
//

import Foundation
import Combine

class AnimalsViewModel: ObservableObject {
    @Published var isLoading = false
    @Published private(set) var state: ResultState<Animal> = .success(content: [])
    
    private let network: AnimalsNetwork
    private var cancellables = Set<AnyCancellable>()
    private(set) var animals = [Animal]()
    
    init(network: AnimalsNetwork){
        self.network = network
    }
    
    func getAnimals() {
        self.isLoading = true
        network.getAnimalList().sink{ [weak self] result in
            self?.isLoading = false
            switch(result){
            case .finished:
                guard let animals = self?.animals else { return }
                self?.state = .success(content: animals)
            case .failure(let error):
                self?.state = .error(error: error)
                print("Error \(error)")
            }
        } receiveValue: { data in
            let animalList = data.animals
            self.animals.append(contentsOf: animalList)
        } .store(in: &cancellables)
    }
    
}
