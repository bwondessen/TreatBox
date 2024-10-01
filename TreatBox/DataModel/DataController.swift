//
//  DataController.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/30/24.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    // Use TreatBox data model as container
    let container = NSPersistentContainer(name: "TreatBox")
    
    @Published var bookmarks: [MealDetailEntity] = []
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
