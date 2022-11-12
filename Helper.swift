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
    static let color = Color.black
    static let cardBackground = Color.gray
    static let vGridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
}
