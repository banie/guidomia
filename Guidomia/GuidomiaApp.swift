//
//  GuidomiaApp.swift
//  Guidomia
//
//  Created by Banie Setijoso on 2023-02-03.
//

import SwiftUI

@main
struct GuidomiaApp: App {
    var body: some Scene {
        WindowGroup {
            CarListView()
        }
    }
    
//    let persistenceController = PersistenceController.shared

//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//    }
}
