//
//  ManageTagsComponent.swift
//  KatalogWK
//
//  Created by Nico Petersen on 10.11.22.
//

import SwiftUI

struct ManageTagsComponent: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Tag.value, ascending: true)],
        animation: .default)
    private var tags: FetchedResults<Tag>
    var body: some View {
        List {
            ForEach(tags) { tag in

                Text(tag.valueWrapped)
            }
            .onDelete(perform: delete)
        }.navigationTitle("Tags verwalten")
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
            }
    }

    private func delete(offsets: IndexSet) {
        withAnimation {
            offsets.map { tags[$0] }.forEach(viewContext.delete)

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

struct ManageTagsComponent_Previews: PreviewProvider {
    static var previews: some View {
        ManageTagsComponent()
    }
}
