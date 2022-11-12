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
    @FetchRequest(sortDescriptors: []) var angelOwner: FetchedResults<AngelOwner>
    @FetchRequest(sortDescriptors: []) var owner: FetchedResults<Owner>

    var body: some View {
        TabView {
            AngelsList()
                .tabItem {
                    Label("Inventar", systemImage: "archivebox")
                }
            AddView()
                .tabItem {
                    Label("Hinzufügen", systemImage: "plus")
                }
            StatisticsView(rawData: angelOwner.map { ao in
                StatisticsRawData(owner: owner.first(where: { o in o.idWrapped == ao.ownerIdWrapped }) ?? Owner(), count: ao.count)
            })
            .tabItem {
                Label("Statistiken", systemImage: "chart.xyaxis.line")
            }
            SettingsView()
                .tabItem {
                    Label("Einstellungen", systemImage: "gear")
                }
        }
    }
}
