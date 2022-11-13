//
//  KatalogWKApp.swift
//  KatalogWK
//
//  Created by Nico Petersen on 07.11.22.
//
//

import SwiftUI

@main
struct ElfPunkteInventarApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Tabs()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
