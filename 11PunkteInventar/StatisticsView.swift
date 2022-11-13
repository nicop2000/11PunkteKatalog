//
//  StatisticsView.swift
//  11PunkteInventar
//
//  Created by Nico Petersen on 12.11.22.
//

import SwiftUI

struct StatisticsView: View {
    @FetchRequest(sortDescriptors: []) var angelOwner: FetchedResults<AngelOwner>
    @FetchRequest(sortDescriptors: []) var owner: FetchedResults<Owner>
    @FetchRequest(sortDescriptors: []) var angel: FetchedResults<Angel>
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    OwnerStatisticsComponent(rawData: angelOwner.map { ao in
                        OwnerStatisticsRawData(owner: owner.first(where: { o in o.idWrapped == ao.ownerIdWrapped }) ?? Owner(), count: ao.count)
                    })
                    MainDivider()
                    ColorStatisticsComponent(rawData: angel.map { a in
                        ColorStatisticsRawData(angel: a, count: angelOwner.filter { ao in ao.itemNrWrapped == a.itemNrWrapped }.reduce(0) { $0 + $1.count })

                    })
                }
                .padding(.top, 10)
                Text("\(angelOwner.reduce(0) { $0 + $1.count }) Engel insgesamt")
                    .padding(.bottom, 10)
                    .padding(.trailing, 10)
            }.navigationTitle("Statistiken")
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
