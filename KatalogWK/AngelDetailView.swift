//
//  AngelDetailView.swift
//  KatalogWK
//
//  Created by Nico Petersen on 08.11.22.
//

import SwiftUI

struct AngelDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @FetchRequest var angelOwner: FetchedResults<AngelOwner>

    let angel: Angel
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Owner.name, ascending: true)],
        animation: .default
    )
    private var owners: FetchedResults<Owner>

    init(angel: Angel) {
        self.angel = angel
        _angelOwner = FetchRequest<AngelOwner>(
            sortDescriptors: [], predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "itemNr == %@", angel.itemNrWrapped),
            ]
            )
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    AngelItemComponent(angel: angel, imageSize: 300, showTitle: false)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("Artikelnummer: \(angel.itemNrWrapped)")
                }
                if angel.descWrapped.count > 0 {
                    HeadlineComponent(text: "Beschreibung")
                    Text(angel.descWrapped)
                }
                HeadlineComponent(text: "Preis")
                Text(angel.price, format: .currency(code: "EUR"))

                HeadlineComponent(text: "Tags")
                LazyVGrid(columns: Helper.vGridLayout, spacing: 20) {
                    ForEach(angel.tags.toTagSet(), id: \.self) { tag in
                        TagComponent(tag: tag)
                    }
                }
                .padding(5)

                HeadlineComponent(text: "Besitzer")
                ForEach(owners, id: \.self) { owner in
                    AngelOwnerComponent(angel: angel, owner: owner)
                }

                HStack {
                    Spacer()
                    Button(action: {
                        do {
                            angelOwner.forEach(viewContext.delete)
                            viewContext.delete(angel)
                            self.presentationMode.wrappedValue.dismiss()
                            try viewContext.save()
                        } catch {}
                    }, label: {
                        Text("Engel löschen")
                            .foregroundColor(.red)
                            .bold()
                    })
                    Spacer()
                }.padding(.top, 40)
            }
            .padding()
            .navigationTitle(angel.titleWrapped)
        }.toolbar {
            ToolbarItem(placement: .navigation) {
                NavigationLink("Bearbeiten") {
                    ScrollView {
                        AddAngelComponent(angel)
                    }
                    .navigationTitle("Engel bearbeiten")
                }.onTapGesture {
                    dismissKeyboard()
                }
            }
        }
    }
}

struct AngelDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AngelDetailView(angel: Angel())
    }
}
