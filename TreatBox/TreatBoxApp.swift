//
//  TreatBoxApp.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/24/24.
//

import SwiftUI

@main
struct TreatBoxApp: App {
    @State private var dataController: DataController = DataController()
    
    @State private var selection: String = MealsView.tab
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selection) {
                MealsView()
                    .tabItem { Image(systemName: "birthday.cake") }
                    .tag(MealsView.tab)
                
                BookmarkView()
                    .tabItem { Image(systemName: "bookmark") }
                    .tag(BookmarkView.tab)
            }
            .tint(.primary)
            .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
