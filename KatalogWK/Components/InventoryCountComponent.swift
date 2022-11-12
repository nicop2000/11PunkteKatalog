//
//  InventoryCount.swift
//  KatalogWK
//
//  Created by Nico Petersen on 09.11.22.
//

import SwiftUI

struct InventoryCountComponent: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var angelOwner: FetchedResults<AngelOwner>
    var body: some View {
        Text("\(angelOwner.reduce(0) { $0 + $1.count })")
    }
}

struct InventoryCount_Previews: PreviewProvider {
    static var previews: some View {
        InventoryCountComponent()
    }
}
