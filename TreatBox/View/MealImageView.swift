//
//  MealImageView.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/26/24.
//

import SwiftUI

struct MealImageView: View {
    @StateObject var loaderViewModel: ImageLoadingViewModel
    
    @State var isLoading: Bool = true
    
    init(url: String, key: String) {
        _loaderViewModel = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
    }
    
    var body: some View {
        ZStack {
            // Show image if not loading
            if loaderViewModel.isLoading {
                ProgressView()
            } else  if let image = loaderViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

#Preview {
    MealImageView(url: "https://www.themealdb.com//images//media//meals//swttys1511385853.jpg", key: "1")
}
