//
//  BookmarkView.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/30/24.
//

import SwiftUI

struct BookmarkView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    
    // Filter bookmark by recently added
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "dateBookmarked", ascending: false)]) var bookmarks: FetchedResults<MealDetailEntity>
    
    static let tab: String = "BookmarkView"
    
    @State var path2: [String] = [String]() // Navigation path
    
    let bookmarkedMeal: MealDetailEntity? = nil
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        if bookmarks.isEmpty {
            // Displays empty view when bookmark is empty
            emptyView
        } else {
            NavigationStack(path: $path2) {
                // Displays bookmark view when bookmark is not empty
                BooksmarkView(path2: $path2, columns: columns)
            }
        }
    }
    
    var emptyView: some View {
        VStack {
            // Light mode
            if colorScheme == .light {
                Image("NoBookmarksLight")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
                // Dark mode
            } else {
                Image("NoBookmarksDark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
            }
            
            Text("Your bookmarks are currently empty...")
                .font(.system(.headline, design: .serif))
            
            Text("Try tapping the \(Image(systemName: "bookmark")) bookmark icon in the detail screens to add and remove recipes!")
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

//#Preview {
//    BookmarkView()
//        .environmentObject(BookmarkViewModel())
//}

struct BooksmarkView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "dateBookmarked", ascending: false)]) var bookmarks: FetchedResults<MealDetailEntity>
    
    @Binding var path2: [String] // Navigation path
    
    let bookmarkedMeal: MealDetailEntity? = nil
    let columns: [GridItem]
    
    var body: some View {
        Button {
            path2 = [bookmarkedMeal?.idMeal ?? ""]
        } label: {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(bookmarks) { bookmark in
                        Button {
                            path2 = [bookmark.idMeal ?? ""]
                        } label: {
                            VStack(alignment: .leading, spacing: 15) {
                                MealImageView(url: bookmark.strMealThumb ?? "", key: bookmark.idMeal ?? "")
                                    .scaledToFill()
                                    .frame(width: 165, height: 188.57)
                                    .clipShape(.rect(cornerRadius: 10))
                                    .overlay (
                                        Button {
                                            withAnimation(.default) {
                                                deleteBookmark(bookmark)
                                            }
                                        } label: {
                                            Image(systemName: "bookmark.fill")
                                                .tint(.white)
                                                .font(.caption)
                                        }
                                            .padding()
                                            .background(.black)
                                            .clipShape(Circle())
                                            .offset(x: 10, y: 10)
                                            .shadow(color: colorScheme == .dark ? .white : .white.opacity(0), radius: colorScheme == .dark ? 3.5 : 0)
                                        , alignment: .bottomTrailing
                                    )
                                
                                Text(bookmark.strMeal ?? "N/A")
                                    .font(.system(.subheadline, design: .serif))
                            }
                        }
                    }
                }
                
                .padding()
                .navigationTitle("Saved Recipes")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: String.self) { selection in
                    MealDetailView(mealDetailViewModel: MealDetailViewModel(), mealID: selection)
                }
            }
        }
    }
    
    func deleteBookmark(_ bookmark: FetchedResults<MealDetailEntity>.Element) {
        moc.delete(bookmark)
        
        try? moc.save()
    }
}
