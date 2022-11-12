//
//  StatisticsView.swift
//  KatalogWK
//
//  Created by Nico Petersen on 09.11.22.
//

import SwiftUI

struct StatisticsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var owner: FetchedResults<Owner>
    private var slices: [PieSlice] = []

    var body: some View {
        VStack(alignment: .center) {
            Text("\(slices.map { $0.data.count }.reduce(0) { $0 + $1 }) Engel insgesamt")
                .padding(.top, 10)
            ZStack(alignment: .center) {
                ForEach(slices, id: \.self) { slice in
                    Path { path in
                        path.move(to: CGPoint(x: 200, y: 200))
                        path.addArc(center: CGPoint(x: 200, y: 200),
                                    radius: 100,
                                    startAngle: slice.start,
                                    endAngle: slice.end,
                                    clockwise: false)
                    }
                    .fill(slice.color)
                }
            }
            ScrollView {
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
    }

    private struct DataToSlice: Hashable {
        var color: Color
        var fraction: Double
        var pieData: PieData
    }

    init(rawData: [StatisticsRawData]) {
        var i = 0
        let total = rawData.reduce(0) { $0 + $1.count }
        var owner: Set<Owner> = []
        rawData.forEach {
            owner.insert($0.owner)
        }
        var data: [DataToSlice] = []
        owner.forEach { owner in
            let count = rawData.filter { $0.owner.idWrapped == owner.idWrapped }.map { $0.count }.reduce(0) { $0 + $1 }
            data.append(DataToSlice(
                color: Helper.colors[i % Helper.colors.count], fraction: Double(count) / Double(total), pieData: PieData(count: count, owner: owner)
            ))
            i += 1
        }

//        data.sort(by: { $0.pieData.owner.nameWrapped < $1.pieData.owner.nameWrapped })
        slices = calculateSlices(from: data)
    }

    // Usage for the example above

    private func calculateSlices(from inputValues: [DataToSlice]) -> [PieSlice] {
        // 1
        let sumOfAllValues = inputValues.reduce(0) { $0 + $1.fraction }
        guard sumOfAllValues > 0 else {
            return []
        }
        let degreeForOneValue = 360.0 / sumOfAllValues
        // 2
        var slices = [PieSlice]()
        var currentStartAngle = 0.0
        inputValues.forEach { inputValue in
            let endAngle = degreeForOneValue * inputValue.fraction +
                currentStartAngle
            slices.append(
                PieSlice(
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

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(rawData: [])
    }
}
