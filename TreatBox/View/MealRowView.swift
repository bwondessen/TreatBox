//
//  MealRowView.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/26/24.
//

import SwiftUI

struct MealRowView: View {
    let mealID: String
    let mealName: String
    
    var body: some View {
        Section {
            HStack {
                MealImageView(url: mealID, key: mealID)
                    .frame(height: 80)
                    .clipShape(.rect(cornerRadius: 10))
                
                Text(mealName)
                
                Spacer()
            }
        }
    }
}


#Preview {
    MealRowView(mealID: "https://www.themealdb.com//images//media//meals//swttys1511385853.jpg", mealName: "New York Cheesecake")
}
