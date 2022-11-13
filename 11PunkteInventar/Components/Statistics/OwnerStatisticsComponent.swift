//
//  StatisticsView.swift
//  KatalogWK
//
//  Created by Nico Petersen on 09.11.22.
//

import SwiftUI

struct OwnerStatisticsComponent: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var owner: FetchedResults<Owner>
    private var slices: [OwnerPieSlice] = []

    var body: some View {
        VStack(alignment: .center) {
            GeometryReader { reader in
                let halfWidth = (reader.size.width / 2)
                let halfHeight = (reader.size.height / 2)
                let radius = min(halfWidth, halfHeight)
                let center = CGPoint(x: halfWidth, y: halfHeight)
                ZStack(alignment: .center) {
                    ForEach(slices, id: \.self) { slice in
                        Path { path in
                            path.move(to: center)
                            path.addArc(center: center,
                                        radius: radius,
                                        startAngle: slice.start,
                                        endAngle: slice.end,
                                        clockwise: false)
                        }
                        .fill(slice.color)
                    }
                }
            }.frame(minHeight: 200)

            LazyVGrid(columns: Helper.vGridLayout, spacing: 20) {
                ForEach(slices, id: \.self) { slice in
                    HStack {
                        Capsule(style: .circular)
                            .foregroundColor(slice.color)
                            .frame(width: 40, height: 30)
                        Text("\(slice.data.owner.nameWrapped) (\(slice.data.count))")
                        Spacer()
                    }
                }
            }
            .padding(10)
        }
    }

    private struct OwnerDataToSlice: Hashable {
        var color: Color
        var fraction: Double
        var pieData: OwnerPieData
    }

    init(rawData: [OwnerStatisticsRawData]) {
        var i = 0
        let total = rawData.reduce(0) { $0 + $1.count }
        var owner: Set<Owner> = []
        rawData.forEach {
            owner.insert($0.owner)
        }
        var data: [OwnerDataToSlice] = []
        owner.forEach { owner in
            let count = rawData.filter { $0.owner.idWrapped == owner.idWrapped }.map { $0.count }.reduce(0) { $0 + $1 }
            data.append(OwnerDataToSlice(
                color: Helper.colors[i % Helper.colors.count], fraction: Double(count) / Double(total), pieData: OwnerPieData(count: count, owner: owner)
            ))
            i += 1
        }

//        data.sort(by: { $0.pieData.owner.nameWrapped < $1.pieData.owner.nameWrapped })
        slices = calculateSlices(from: data)
    }

    // Usage for the example above

    private func calculateSlices(from inputValues: [OwnerDataToSlice]) -> [OwnerPieSlice] {
        // 1
        let sumOfAllValues = inputValues.reduce(0) { $0 + $1.fraction }
        guard sumOfAllValues > 0 else {
            return []
        }
        let degreeForOneValue = 360.0 / sumOfAllValues
        // 2
        var slices = [OwnerPieSlice]()
        var currentStartAngle = 0.0
        inputValues.forEach { inputValue in
            let endAngle = degreeForOneValue * inputValue.fraction +
                currentStartAngle
            slices.append(
                OwnerPieSlice(
                    start: Angle(degrees: currentStartAngle),
                    end: Angle(degrees: endAngle),
                    color: inputValue.color,
                    data: inputValue.pieData
                )
            )
            currentStartAngle = endAngle
        }
        return slices
    }
}

struct OwnerStatisticsComponent_Previews: PreviewProvider {
    static var previews: some View {
        OwnerStatisticsComponent(rawData: [])
    }
}
