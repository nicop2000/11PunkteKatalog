//
//  AngelsList.swift
//  KatalogWK
//
//  Created by Nico Petersen on 07.11.22.
//

import SwiftUI

struct AngelsList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Angel.title, ascending: true)],
        animation: .default)
    private var angels: FetchedResults<Angel>

    @FetchRequest(sortDescriptors: []) private var angelOwner: FetchedResults<AngelOwner>

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: Helper.vGridLayout, spacing: 20) {
                        ForEach(angels, id: \.self) { angel in
                            NavigationLink(destination: AngelDetailView(angel: angel)) {
                                AngelItemComponent(angel: angel)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .navigationTitle("Engel-Inventar (\(angelOwner.reduce(0) { $0 + $1.count }))")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { angels[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AngelsList_Previews: PreviewProvider {
    static var previews: some View {
        AngelsList()
    }
}
