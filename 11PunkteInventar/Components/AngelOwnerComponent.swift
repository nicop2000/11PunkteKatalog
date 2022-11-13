//
//  AngelOwnerTile.swift
//  KatalogWK
//
//  Created by Nico Petersen on 08.11.22.
//

import SwiftUI

struct AngelOwnerComponent: View {
    @Environment(\.managedObjectContext) private var viewContext
    let angel: Angel
    let owner: Owner
    @FetchRequest var all: FetchedResults<AngelOwner>

    init(angel: Angel, owner: Owner) {
        self.angel = angel
        self.owner = owner
        _all = FetchRequest<AngelOwner>(
            sortDescriptors: [], predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "itemNr == %@", angel.itemNrWrapped),
                NSPredicate(format: "ownerId == %@", owner.idWrapped)
            ]
            )
        )
    }

    var body: some View {
        HStack {
            Text(owner.nameWrapped)
                .padding(.trailing, 5)
            Button {
                decrease()
            } label: {
                Image(systemName: "minus")
            }
            Text("\(all.first?.count ?? 0)")

            Button {
                increase()
            } label: {
                Image(systemName: "plus")
            }
        }
        .padding(.top, 5)
    }

    func increase() {
        if all.first(where: { $0.ownerId == owner.id }) == nil {
            let ao = AngelOwner(context: viewContext)
            ao.ownerId = owner.id
            ao.itemNr = angel.itemNr
            ao.count = 1

        } else {
            all.first(where: { $0.ownerId == owner.id })!.count += 1
        }
        save()
    }

    func decrease() {
        let itemToChange = all.first(where: { $0.ownerIdWrapped == owner.idWrapped })
        if itemToChange?.count ?? 0 > 0 {
            itemToChange!.count -= 1
        }
        save()
    }

    func save() {
        // TODO: ERROR HANDLING
        try? viewContext.save()
    }
}

struct AngelOwnerTile_Previews: PreviewProvider {
    static var previews: some View {
        AngelOwnerComponent(angel: Angel(), owner: Owner())
    }
}
