//
//  Test.swift
//  11PunkteInventar
//
//  Created by Nico Petersen on 12.11.22.
//

import SwiftUI

struct Test: View {
    let a = (1 ... 100).map { "Item \($0)" }
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text("\\(slices.map { $0.data.count }.reduce(0) { $0 + $1 }) Engel insgesamt")
                    .padding(.top, 10)
                
                LazyVGrid(columns: Helper.vGridLayout, spacing: 20) {
                    ForEach(a, id: \.self) { _ in
                        HStack {
                            Capsule(style: .circular)
//                                .foregroundColor(slice.color)
                                .frame(width: 40, height: 30)
                            Text("\\(slice.data.owner.nameWrapped) (\\(slice.data.count))")
                            Spacer()
                        }
                    }
                }
                .padding(10)
            }
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
