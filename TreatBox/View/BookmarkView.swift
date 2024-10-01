//
//  BookmarkView.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/30/24.
//

import SwiftUI

struct BookmarkView: View {
    @Environment(\.managedObjectContext) var moc
    
    // Filter bookmark by recently added
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "dateBookmarked", ascending: false)]) var bookmarks: FetchedResults<MealDetailEntity>
        
    static let tab: String = "BookmarkView"
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        if bookmarks.isEmpty {
            // Displays empty view when bookmark is empty
            emptyView
        } else {
            NavigationStack {
                // Displays bookmark view when bookmark is not empty
                BookmarskView(columns: columns, bookmarks: bookmarks)
            }
        }
    }
    
    var emptyView: some View {
        VStack {
            Image("NoBookmarks")
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 350)
            
            Text("Your bookmarks are currently empty...")
                .font(.system(.headline, design: .serif))
            
            Group {
                Text("Try tapping the \(Image(systemName: "bookmark")) bookmark icon in the dessert list and detail screens to add and remove recipes!")
            }
            .multilineTextAlignment(.center)
            .padding()
        }
    }
}

//#Preview {
//    BookmarkView()
//        .environmentObject(BookmarkViewModel())
//}

struct BookmarskView: View {
    @Environment(\.managedObjectContext) var moc
    
    let columns: [GridItem]
    let bookmarks: FetchedResults<MealDetailEntity>
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(bookmarks) { bookmark in
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
                                , alignment: .bottomTrailing
                            )
                        
                        Text(bookmark.strMeal ?? "N/A")
                            .font(.system(.subheadline, design: .serif))
                    }
                }
            }
            .padding()
            .navigationTitle("Saved Recipes")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func deleteBookmark(_ bookmark: FetchedResults<MealDetailEntity>.Element) {
        moc.delete(bookmark)
        
        try? moc.save()
    }
}
