//
//  ManageOwnerComponent.swift
//  KatalogWK
//
//  Created by Nico Petersen on 10.11.22.
//

import SwiftUI

struct ManageOwnerComponent: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Owner.name, ascending: true)],
        animation: .default)
    private var owners: FetchedResults<Owner>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \AngelOwner.ownerId, ascending: true)],
        animation: .default)
    private var angelOwners: FetchedResults<AngelOwner>
    var body: some View {
        List {
            ForEach(owners) { owner in

                Text(owner.nameWrapped)
            }
            .onDelete(perform: delete)
        }.navigationTitle("Besitzer verwalten")
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
            offsets.map { owners[$0] }.forEach { owner in

                angelOwners.filter { $0.ownerIdWrapped == owner.id }.forEach(viewContext.delete)
                viewContext.delete(owner)
            }

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

struct ManageOwnerComponent_Previews: PreviewProvider {
    static var previews: some View {
        ManageOwnerComponent()
    }
}
