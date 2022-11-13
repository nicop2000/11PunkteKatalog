//
//  MainDivider.swift
//  KatalogWK
//
//  Created by Nico Petersen on 11.11.22.
//

import SwiftUI

struct MainDivider: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Divider()
            .frame(height: 1)
            .overlay(colorScheme == .dark ? .white : .black)
    }
}

struct MainDivider_Previews: PreviewProvider {
    static var previews: some View {
        MainDivider()
    }
}
