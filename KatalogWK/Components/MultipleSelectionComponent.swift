//
//  MultipleSelectionComponent.swift
//  KatalogWK
//
//  Created by Nico Petersen on 10.11.22.
//

import SwiftUI

struct MultipleSelectionComponent: View {
    var tag: Tag
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                TagComponent(tag: tag)
                if isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                }
            }
        }
        .foregroundColor(Helper.color)
    }
}

struct MultipleSelectionComponent_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSelectionComponent(tag: Tag(), isSelected: false, action: {})
    }
}
