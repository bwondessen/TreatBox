//
//  YouTubeLinkView.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/27/24.
//

import SwiftUI

struct YouTubeLinkView: View {
    let mealDetailViewModel: MealDetailViewModel
    
    var body: some View {
        if mealDetailViewModel.meal?.strYoutube?.count ?? 0 > 0 {
            VideoAvailable(mealDetailViewModel: mealDetailViewModel)
        } else {
            VideoUnavailable()
        }
    }
}

//#Preview {
//    YouTubeLinkView(meal: MealDetailViewModel())
//}

struct VideoAvailable: View {
    let mealDetailViewModel: MealDetailViewModel
    
    var body: some View {
        Link(destination: URL(string: mealDetailViewModel.meal?.strYoutube ?? "")!) {
            HStack {
                Image(systemName: "play.rectangle.fill")
                    .foregroundStyle(.red)
                    .font(.title3)
                Text("YouTube")
                    .font(.headline)
                    .foregroundStyle(.black)
            }
            .padding()
            .background(.white)
            .clipShape(.rect(cornerRadius: 15))
            .shadow(color: .red, radius: 2.5)
        }
        .padding(.top)
    }
}

struct VideoUnavailable: View {
    var body: some View {
        VStack {
            Text("video unavailable")
                .italic()
            
            HStack {
                Image(systemName: "play.rectangle.fill")
                    .font(.callout)
                
                Text("YouTube")
                    .font(.headline)
                    .foregroundStyle(.primary)
            }
            .padding()
            .background(.white)
            .clipShape(.rect(cornerRadius: 15))
            .shadow(radius: 2.5)
        }
        .padding(.top)
    }
}
