//
//  AddOwnerView.swift
//  KatalogWK
//
//  Created by Nico Petersen on 08.11.22.
//

import SwiftUI

struct AddOwnerComponent: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var name: String = ""
    var body: some View {
        VStack {
            HStack {
                Text("Neuen Besitzer anlegen")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            HStack {
                HeadlineComponent(text: "Name:", small: true)
                TextField("Name des Besitzers", text: $name)
                    .textFieldStyle(.roundedBorder)
            }
            Button("Besitzer hinzufügen") {
                addOwner()
            }
            .padding()
        }
        .padding()
    }

    private func addOwner() {
        withAnimation {
            let newOwner = Owner(context: viewContext)
            newOwner.name = name
            newOwner.id = UUID().uuidString

            do {
                try viewContext.save()
                name = ""
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddOwnerView_Previews: PreviewProvider {
    static var previews: some View {
        AddOwnerComponent()
    }
}
