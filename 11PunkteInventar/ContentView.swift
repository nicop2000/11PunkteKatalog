//
//  ContentView.swift
//  KatalogWK
//
//  Created by Nico Petersen on 07.11.22.
//
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        TabView {
            StatisticsView()
                .tabItem {
                    Label("Statistiken", systemImage: "chart.xyaxis.line")
                }
            AngelsListView()
                .tabItem {
                    Label("Inventar", systemImage: "archivebox")
                }
            AddView()
                .tabItem {
                    Label("Hinzufügen", systemImage: "plus")
                }

            SettingsView()
                .tabItem {
                    Label("Einstellungen", systemImage: "gear")
                }
        }
    }
}
