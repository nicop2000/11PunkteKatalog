//
//  ColorStatisticsComponent.swift
//  11PunkteInventar
//
//  Created by Nico Petersen on 12.11.22.
//

import SwiftUI

//
//  StatisticsView.swift
//  KatalogWK
//
//  Created by Nico Petersen on 09.11.22.
//

import SwiftUI

struct ColorStatisticsComponent: View {
    @Environment(\.managedObjectContext) private var viewContext
    private var slices: [ColorPieSlice] = []

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
                        Text("\(slice.data.colorString) (\(slice.data.count))")
                        Spacer()
                    }
                }
            }
            .padding(10)
        }
    }

    private struct ColorDataToSlice: Hashable {
        var color: Color
        var fraction: Double
        var pieData: ColorPieData
    }

    init(rawData: [ColorStatisticsRawData]) {
        let total = Double(rawData.reduce(0) { $0 + $1.count })
        var data: [ColorDataToSlice] = []
        let brownCount = rawData.filter { $0.angel.colorWrapped == "Braun" }.reduce(0) { $0 + $1.count }
        let blondeCount = rawData.filter { $0.angel.colorWrapped == "Blond" }.reduce(0) { $0 + $1.count }

        data.append(ColorDataToSlice(color: Helper.brown, fraction: Double(brownCount) / total, pieData: ColorPieData(count: brownCount, colorString: "Braun")))
        data.append(ColorDataToSlice(color: .yellow, fraction: Double(blondeCount) / total, pieData: ColorPieData(count: blondeCount, colorString: "Blond")))

        slices = calculateSlices(from: data)
    }

    // Usage for the example above

    private func calculateSlices(from inputValues: [ColorDataToSlice]) -> [ColorPieSlice] {
        // 1
        let sumOfAllValues = inputValues.reduce(0) { $0 + $1.fraction }
        guard sumOfAllValues > 0 else {
            return []
        }
        let degreeForOneValue = 360.0 / sumOfAllValues
        // 2
        var slices = [ColorPieSlice]()
        var currentStartAngle = 0.0
        inputValues.forEach { inputValue in
            let endAngle = degreeForOneValue * inputValue.fraction +
                currentStartAngle
            slices.append(
                ColorPieSlice(
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

struct ColorStatisticsComponent_Previews: PreviewProvider {
    static var previews: some View {
        ColorStatisticsComponent(rawData: [])
    }
}
