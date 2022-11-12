//
//  AddView.swift
//  KatalogWK
//
//  Created by Nico Petersen on 08.11.22.
//

import SwiftUI

struct AddView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    AddAngelComponent()
                    MainDivider()
                    AddOwnerComponent()
                    MainDivider()
                    AddTagComponent()
                }
            }
            .navigationTitle("Hinzufügen")
        }.onTapGesture {
            dismissKeyboard()
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
