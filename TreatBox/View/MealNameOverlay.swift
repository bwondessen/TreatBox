//
//  MealNameOverlay.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/27/24.
//

import SwiftUI

struct MealNameOverlay: View {
    @FetchRequest(sortDescriptors: []) var bookmarks: FetchedResults<MealDetailEntity>
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    
    @State var mealDetailEntities: Array<MealDetailEntity> = []
    
    let meal: MealDetail
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(colorScheme == .light ? .white : .black)
                .frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height * 0.12)
                .clipShape(.rect(cornerRadius: 15))
                .shadow(color: colorScheme == .dark ? .white : .white.opacity(0), radius: colorScheme == .dark ? 3.5 : 0)
                .shadow(radius: colorScheme == .light ? 3.5 : 0)
                .overlay (
                    Button {
                        withAnimation(.default) {
                            updateBookmark(meal: meal)
                        }
                    } label: {
                        if bookmarks.contains(where: { ($0.idMeal == meal.idMeal) && $0.isBookmarked })  {
                            Image(systemName: "bookmark.fill")
                        } else {
                            Image(systemName: "bookmark")
                        }
                    }
                        .tint(.white)
                        .font(.subheadline)
                        .padding()
                        .background(.black)
                        .clipShape(Circle())
                        .offset(x: 8, y: 8)
                        .shadow(color: colorScheme == .dark ? .white : .white.opacity(0), radius: colorScheme == .dark ? 3.5 : 0)
                    , alignment: .bottomTrailing
                )
            
            VStack {
                Text("RECIPE")
                    .foregroundStyle(.secondary)
                    .italic()
                    .font(.subheadline)
                
                Text(meal.strMeal)
                    .font(.system(.title3, design: .serif))
                    .bold()
            }
        }
        .offset(y: 60)
    }
    
    // Add or remove bookmark
    func updateBookmark(meal: MealDetail) {
        // Add to bookmark if it's not already bookmarked
        guard bookmarks.contains(where: { ($0.idMeal == meal.idMeal) }) else {
            let bookmarkedMeal = MealDetailEntity(context: moc)
            bookmarkedMeal.idMeal = meal.idMeal
            bookmarkedMeal.strMeal = meal.strMeal
            bookmarkedMeal.strMealThumb = meal.strMealThumb
            bookmarkedMeal.isBookmarked = true
            bookmarkedMeal.dateBookmarked = Date()
            
            try? moc.save()
            
            return
        }
        
        // Remove bookmark if it's already bookmarked
        mealDetailEntities = Array(bookmarks)
        
        mealDetailEntities = mealDetailEntities.filter( { $0.idMeal == meal.idMeal })
        
        moc.delete(mealDetailEntities[0])
        
        try? moc.save()
    }
}

#Preview {
    MealNameOverlay(meal: MealDetail.mealDetailPreview)
}
