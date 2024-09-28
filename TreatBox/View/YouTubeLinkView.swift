//
//  YouTubeLinkView.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/27/24.
//

import SwiftUI

struct YouTubeLinkView: View {
    let meal: MealDetailViewModel
    
    var body: some View {
        Link(destination: URL(string: meal.meal?.strYoutube ?? "")!) {
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

//#Preview {
//    YouTubeLinkView(meal: MealDetailViewModel())
//}
