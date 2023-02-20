//
//  AnimalCellView.swift
//  PetFinder
//
//  Created by Consultant on 1/25/23.
//

import SwiftUI

struct AnimalCellView: View {
    let animal: Animal
    var body: some View {
        HStack {
            ImageLoaderView(imageUrl: getAnimalImage(animal: animal))
                .scaledToFit()
                .frame(width: 100, height: 100)
                .background(.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4){
                Text(animal.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                Text(animal.species ?? "No info")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
            }
        }
    }
    
    func getAnimalImage(animal: Animal) -> String {
        if(animal.photos.count > 0) {
            guard let imageUrl = animal.photos[0].small else {
                return ""
            }
            return imageUrl
        }
        return ""
    }
}

struct AnimalCellView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalCellView(animal: Animal.mockAnimal)
    }
}
