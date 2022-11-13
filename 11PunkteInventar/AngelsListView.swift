//
//  AngelsList.swift
//  KatalogWK
//
//  Created by Nico Petersen on 07.11.22.
//

import SwiftUI

struct AngelsListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Angel.title, ascending: true)],
        animation: .default)
    private var angels: FetchedResults<Angel>

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Tag.value, ascending: true)],
        animation: .default)
    private var tags: FetchedResults<Tag>
    @FetchRequest(sortDescriptors: []) private var angelOwner: FetchedResults<AngelOwner>

    @State private var showingFilterView = false

    @State private var stringFilter: String = ""

    @State private var filterValues: [String] = []
    @State private var andSearch: Bool = false

    let sortOptions = ["Name", "Preis"]
    @State private var sortBy = "Name"
    @State private var sortAscending = true

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: Helper.vGridLayout, spacing: 20) {
                        ForEach(getFilteredList(),
                                id: \.self) { angel in
                            NavigationLink(destination: AngelDetailView(angel: angel)) {
                                AngelItemComponent(angel: angel)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .navigationTitle("Engel-Inventar (\(angelOwner.reduce(0) { $0 + $1.count }))")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    if !stringFilter.isEmpty || !filterValues.isEmpty {
                        Button {
                            stringFilter = ""
                            filterValues = []
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                    Spacer()
                    Button {
                        showingFilterView = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }.sheet(isPresented: $showingFilterView) {
            if #available(iOS 16.0, *) {
                BottomSheetContent()
                    .presentationDetents([.medium, .large])
            } else {
                BottomSheetContent()
            }
        }
    }

    private func BottomSheetContent() -> some View {
        return
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showingFilterView = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                .padding(.top, 20)
                .padding(.trailing, 20)
                HStack {
                    HeadlineComponent(text: "Sortieren nach", small: true)
                    Picker("Sortieren nach", selection: $sortBy) {
                        ForEach(sortOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    Toggle("Aufsteigend", isOn: $sortAscending)
                }
                .padding()
                HStack {
                    HeadlineComponent(text: "Suchen:", small: true)
                    TextField("Suchbegriff", text: $stringFilter)
                        .textFieldStyle(.roundedBorder)
                        .padding(.top, 5)
                        .onSubmit {
                            filterValues.append(stringFilter)
                            stringFilter = ""
                        }
                }.padding()
                Toggle("Müssen alle Suchbegriffe zutreffen?", isOn: $andSearch)
                    .padding(.leading, 15)
                    .padding(.trailing, 20)
                List {
                    ForEach(filterValues, id: \.self) { value in
                        Text(value)
                    }
                    .onDelete(perform: delete)
                }
                Spacer()
            }
    }

    func delete(at offsets: IndexSet) {
        filterValues.remove(atOffsets: offsets)
    }

    private func getFilteredList() -> [Angel] {
        var result: [Angel] = []
        if filterValues.isEmpty {
            result.append(contentsOf: angels)
        } else {
            angels.forEach { angel in

                if andSearch {
                    if angel.matchesAllInStringList(filterValues) {
                        result.append(angel)
                    }
                } else {
                    if angel.matchesSomeInStringList(filterValues) {
                        result.append(angel)
                    }
                }
            }
        }
        return sortList(Array(Set(result)))
    }

    private func sortList(_ list: [Angel]) -> [Angel] {
        var result = list
        if sortBy == "Name" {
            result.sort(by: { $0.titleWrapped < $1.titleWrapped })
        } else if sortBy == "Preis" {
            result.sort(by: { $0.price < $1.price })
        }
        if !sortAscending {
            result.reverse()
        }

        return result
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
        AngelsListView()
    }
}
