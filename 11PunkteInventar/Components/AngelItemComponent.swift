//
//  AngelItem.swift
//  KatalogWK
//
//  Created by Nico Petersen on 07.11.22.
//

import SwiftUI

struct AngelItemComponent: View {
    @FetchRequest var angelOwner: FetchedResults<AngelOwner>
    let angel: Angel
    let imageSize: CGFloat
    let showTitle: Bool

    init(angel: Angel, imageSize: CGFloat = 80, showTitle: Bool = true) {
        self.imageSize = imageSize
        self.showTitle = showTitle
        self.angel = angel
        _angelOwner = FetchRequest<AngelOwner>(
            sortDescriptors: [], predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "itemNr == %@", angel.itemNrWrapped)
            ]
            )
        )
    }

    var body: some View {
        VStack {
            if angel.image != nil {
                Image(uiImage: UIImage(data: angel.image!)!)
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .padding(5)
            } else {
                Spacer()
                    .frame(height: imageSize)
            }
            if showTitle {
                VStack {
                    Text(angel.titleWrapped)
                        .font(.title3)

                    Text("(\(angelOwner.reduce(0) { $0 + $1.count }))")
                        .font(.title3)
                }
            }
        }
    }
}

struct AngelItem_Previews: PreviewProvider {
    static var previews: some View {
        AngelItemComponent(angel: Angel())
    }
}
