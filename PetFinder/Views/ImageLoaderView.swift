//
//  ImageLoaderView.swift
//  PetFinder
//
//  Created by Consultant on 1/25/23.
//

import SwiftUI

struct ImageLoaderView: View {
    @StateObject var vm: ImageLoaderViewModel
    
    init(imageUrl: String){
        _vm = StateObject(wrappedValue: ImageLoaderViewModel(imageUrl: imageUrl))
    }
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }else if vm.isLoading {
                ProgressView()
            }else {
                Image(systemName: "pawprint.circle.fill")
                    .font(.system(size: 64))
            }
        }
    }
}

struct ImageLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoaderView(imageUrl: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/59496811/1/?bust=1674148178&width=100")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
