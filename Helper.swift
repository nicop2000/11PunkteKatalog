//
//  Helper.swift
//  KatalogWK
//
//  Created by Nico Petersen on 09.11.22.
//

import CoreData
import Foundation

import SwiftUI

class Helper {
    static let colors: [Color] = [
        .pink,
        .green,
        .yellow,
        .mint,
        .purple,
        .orange,
        .blue,
        .cyan,
        .red,
        .indigo,
        .brown,
        .teal,
        .gray,
    ]
    // TODO: Theme einarbeiten
    static let color = Color.white
    static let cardBackground = Color.gray
    static let vGridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    static let brown = Color(red: 66 / 255, green: 40 / 255, blue: 14 / 255)

    static func sliceItemNr(_ string: String) -> String {
        let split = string.split(separator: "$")
        if split.count > 0 {
            return String(string.split(separator: "$")[0])
        } else {
            return ""
        }
    }
}
