//
//  AnimalListView.swift
//  PetFinder
//
//  Created by Consultant on 1/25/23.
//

import SwiftUI

struct AnimalListView: View {
    
    @StateObject var vm: AnimalsViewModel = AnimalsViewModel(network: AnimalsNetwork())
    
    var body: some View {
            Group {
                switch(vm.state){
                case .error(let error):
                    Text(error.localizedDescription)
                case .success(let animals):
                    NavigationView {
                        List {
                            ForEach(animals) { animal in
                               AnimalCellView(animal: animal)
                            }
                        }
                        .navigationTitle("Animal list")
                    }
                }
            }.onAppear(perform: vm.getAnimals)
    }
}

struct AnimalListView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalListView()
    }
}
