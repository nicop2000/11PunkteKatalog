//
//  PieSlice.swift
//  KatalogWK
//
//  Created by Nico Petersen on 09.11.22.
//

import Foundation
import SwiftUI

public struct PieSlice: Hashable {
    var start: Angle
    var end: Angle
    var color: Color
    var data: PieData
}
