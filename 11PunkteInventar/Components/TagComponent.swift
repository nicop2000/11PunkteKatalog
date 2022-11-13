//
//  TagComponent.swift
//  KatalogWK
//
//  Created by Nico Petersen on 10.11.22.
//

import SwiftUI

struct TagComponent: View {
    let tag: Tag
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Helper.cardBackground)

            VStack {
                Text(tag.valueWrapped)

                    .foregroundColor(.black)
            }
            .padding(3)
            .multilineTextAlignment(.center)
        }
    }
}

struct TagComponent_Previews: PreviewProvider {
    static var previews: some View {
        TagComponent(tag: Tag())
    }
}
