//
//  AddAngelView.swift
//  KatalogWK
//
//  Created by Nico Petersen on 07.11.22.
//

import SwiftUI

struct AddAngelComponent: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var title: String
    @State private var itemNr: String
    @State private var price: Float
    @State private var discontinued: Bool

    @State private var showPicSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var image: UIImage?
    @State private var color: String
    @State private var desc: String
    let colorChoices: [String] = ["Braun", "Blond"]
    let imageSize: CGFloat = 100
    let contentPadding: CGFloat = 5
    let angel: Angel?

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Tag.value, ascending: true)],
        animation: .default)
    private var tags: FetchedResults<Tag>

    @State var selections: [Tag] = []

    init(_ angel: Angel? = nil) {
        self.angel = angel
        _title = State(initialValue: angel?.titleWrapped ?? "")
        _itemNr = State(initialValue: Helper.sliceItemNr(angel?.itemNrWrapped ?? ""))
        _price = State(initialValue: angel?.price ?? 0.0)
        _discontinued = State(initialValue: angel?.discontinued ?? false)
        _image = State(initialValue: angel?.image != nil ? UIImage(data: (angel?.image)!, scale: 1.0) : nil)
        _color = State(initialValue: angel?.colorWrapped ?? "Braun")
        _desc = State(initialValue: angel?.descWrapped ?? "")
        _selections = State(initialValue: angel?.tags.toTagSet() ?? [])
    }

    var body: some View {
        VStack(alignment: .leading) {
            if angel == nil {
                Text("Engel hinzufügen")
                    .font(.title2)
                    .bold()
            }
            HStack {
                HeadlineComponent(text: "Name:", small: true)
                TextField("Name des Engels", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .padding(.top, contentPadding)
            }

            HStack {
                HeadlineComponent(text: "Haarfarbe:", small: true)
                Picker("Haarfarbe", selection: $color) {
                    ForEach(colorChoices, id: \.self) {
                        Text($0)
                    }
                }
                .colorMultiply(.red) // TODO: richtige Farbe einstellen
                .pickerStyle(SegmentedPickerStyle())
            }
            HStack {
                HeadlineComponent(text: "Artikelnummer:", small: true)
                TextField("Artikelnummer", text: $itemNr)
                    .textFieldStyle(.roundedBorder)
                    .padding(.top, contentPadding)
            }
            VStack {
                HeadlineComponent(text: "Tags", small: true, leading: true)
                if tags.isEmpty {
                    HStack {
                        Text("Keine Tags vorhanden")
                        Spacer()
                    }.padding(.top, 5)
                } else { LazyVGrid(columns: Helper.vGridLayout, spacing: 20) {
                    ForEach(tags, id: \.self) { tag in
                        MultipleSelectionComponent(tag: tag, isSelected: self.selections.contains(tag)) {
                            if self.selections.contains(tag) {
                                self.selections.removeAll(where: { $0 == tag })
                            } else {
                                self.selections.append(tag)
                            }
                        }.padding(0)
                    }
                }.padding(.top, 5)
                }
            }
            HStack {
                HeadlineComponent(text: "Preis:", small: true)
                TextField("7.98€", value: $price, format: .currency(code: "EUR"))
                    .textFieldStyle(.roundedBorder)
                    .padding(.top, contentPadding)
                    .keyboardType(.decimalPad)
            }
            Toggle(isOn: $discontinued, label: {
                HeadlineComponent(text: "Produktion eingestellt?", small: true)
            })
            .padding(.top, contentPadding)
            HStack {
                HeadlineComponent(text: "Beschreibung:", small: true)
                TextField("Beschreibung", text: $desc)
                    .textFieldStyle(.roundedBorder)
                    .padding(.top, contentPadding)
            }
            HStack {
                VStack {
                    if image == nil {
                        Button("Bild hinzufügen") {
                            showPicSheet = true
                        }
                        .padding(.top, contentPadding)
                        .actionSheet(isPresented: $showPicSheet) {
                            ActionSheet(title: Text("Bild auswählen"), message: Text("Woher soll das Bild kommen?"), buttons: [
                                .default(Text("Fotomediathek")) {
                                    self.showImagePicker = true
                                    self.sourceType = .photoLibrary
                                },
                                .default(Text("Foto aufnehmen")) {
                                    self.showImagePicker = true
                                    self.sourceType = .camera
                                },
                                .cancel(),
                            ])
                        }
                    } else {
                        Button("Bild löschen") {
                            image = nil
                        }
                    }
                }
                Spacer()
                if image != nil {
                    Image(uiImage: image!)
                        .resizable()
                        .frame(width: imageSize, height: imageSize)
                        .padding(.trailing, contentPadding)
                        .padding(.top, contentPadding)
                }
            }
            HStack {
                Spacer()
                Button(angel != nil ? "Engel speichern" : "Engel hinzufügen") {
                    addAngel()
                }
                .padding(.top, contentPadding)
                Spacer()
            }
        }
        .padding()

        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
    }

    private func addAngel() {
        // TODO: Add Validation
        // TODO: Add Error Handling
        withAnimation {
            if angel == nil {
                let newAngel = Angel(context: viewContext)
                newAngel.title = title
                newAngel.itemNr = "\(itemNr)$\(color)"
                newAngel.price = price
                newAngel.discontinued = discontinued
                newAngel.color = color
                newAngel.image = image?.jpegData(compressionQuality: 0.1)
                selections.forEach(newAngel.addToTags)
                newAngel.desc = desc
            } else {
                if angel!.tags != nil {
                    angel!.tags! = []
                }
                angel!.title = title
                angel!.itemNr = "\(itemNr)$\(color)"
                angel!.price = price
                angel!.discontinued = discontinued
                angel!.color = color
                angel!.image = image?.jpegData(compressionQuality: 0.1)
                selections.forEach(angel!.addToTags)
                angel!.desc = desc
            }

            do {
                try viewContext.save()
                title = ""
                itemNr = ""
                price = 0
                discontinued = false
                image = nil
                selections = []
                desc = ""
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddAngelView_Previews: PreviewProvider {
    static var previews: some View {
        AddAngelComponent()
    }
}
