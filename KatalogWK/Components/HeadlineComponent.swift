//
//  HeadlineComponent.swift
//  KatalogWK
//
//  Created by Nico Petersen on 10.11.22.
//

import SwiftUI

struct HeadlineComponent: View {
    let text: String
    @State var small: Bool = false
    @State var leading: Bool = false
    var body: some View {
        if leading {
            HStack {
                textUI()
                Spacer()
            }
        } else {
            textUI()
        }
    }

    func textUI() -> some View {
        Text(text)
            .font(small ? .headline : .title)
            .bold()
            .padding(.top, 5)
    }
}

struct HeadlineComponent_Previews: PreviewProvider {
    static var previews: some View {
        HeadlineComponent(text: "Test123")
    }
}
