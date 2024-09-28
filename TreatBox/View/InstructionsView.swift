//
//  InstructionsView.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/27/24.
//

import SwiftUI

struct InstructionsView: View {
    let mealDetailViewModel: MealDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Instructions")
                .padding(.bottom, 7.5)
                .font(.system(.headline, design: .serif))
            
            ForEach(0..<(mealDetailViewModel.meal?.instructions.count ?? 0), id: \.self) { i in
                Text("Step \(i + 1)")
                    .italic()
                    .font(.callout)
                    .padding(.top, 3.5)
                    .padding(.bottom, 1)
                    .underline()
                
                Text(mealDetailViewModel.meal?.instructions[i] ?? "N/A")
                    .font(.system(.callout, design: .rounded))
            }
        }
    }
}

#Preview {
    InstructionsView(mealDetailViewModel: MealDetailViewModel())
}
