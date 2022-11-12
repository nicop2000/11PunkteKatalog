//
//  SettingsView.swift
//  KatalogWK
//
//  Created by Nico Petersen on 09.11.22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink("Besitzer verwalten") {
                        ManageOwnerComponent()
                    }
                    NavigationLink("Tags verwalten") {
                        ManageTagsComponent()
                    }
                }
            }.navigationTitle("Einstellungen")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
