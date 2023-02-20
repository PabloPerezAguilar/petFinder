//
//  AnimalItemViewModel.swift
//  PetFinder
//
//  Created by Consultant on 1/25/23.
//

import Foundation
import SwiftUI
import Combine

class ImageLoaderViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var image: UIImage?
    private var network: Network
    private var cancellables = Set<AnyCancellable>()
    
    init(network: Network = Network(), imageUrl: String = ""){
        self.network = network
        getImage(from: imageUrl)
    }
    
    func getImage(from imageUrl: String) {
        isLoading = true
        if(imageUrl.count > 0){
            network.loadImage(imageUrl).sink { [weak self] error in
                self?.isLoading = false
                print("error image: \(error)")
            } receiveValue: { [weak self] image in
                self?.image = image
            }.store(in: &cancellables)
        }else{
            isLoading = false
        }
        
    }
}

