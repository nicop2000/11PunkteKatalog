//
//  AddTag.swift
//  KatalogWK
//
//  Created by Nico Petersen on 10.11.22.
//

import SwiftUI

struct AddTagComponent: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var tagString: String = ""
    var body: some View {
        VStack {
            HStack {
                Text("Neuen Tag anlegen")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            HStack {
                HeadlineComponent(text: "Tag-Name:", small: true)
                TextField("Name des Tags", text: $tagString)
                    .textFieldStyle(.roundedBorder)
                    .padding(.top, 5)
            }
            Button("Tag hinzufügen") {
                let tag = Tag(context: viewContext)
                tag.value = tagString
                do {
                    try viewContext.save()
                    tagString = ""
                } catch {
                    // TODO: Errorhandling
                }
            }
        }
        .padding()
    }
}

struct AddTag_Previews: PreviewProvider {
    static var previews: some View {
        AddTagComponent()
    }
}
