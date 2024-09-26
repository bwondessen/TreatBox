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
    
    init(url: String) {
        _loaderViewModel = StateObject(wrappedValue: ImageLoadingViewModel(url: url))
    }
    
    var body: some View {
        ZStack {
            if loaderViewModel.isLoading {
                ProgressView()
            } else  if let image = loaderViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .clipShape(.rect(cornerRadius: 10))
            }
        }
    }
}

#Preview {
    DownloadingImageView(url: "https://www.themealdb.com//images//media//meals//swttys1511385853.jpg")
 }
