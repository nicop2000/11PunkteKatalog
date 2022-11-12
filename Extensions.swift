//
//  Extensions.swift
//  KatalogWK
//
//  Created by Nico Petersen on 08.11.22.
//

import Foundation
import SwiftUI

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension NSSet? {
    func toAngelSet() -> [Angel] {
        if self != nil {
            return Array(self as! Set<Angel>)
        }
        return []
    }

    func toOwnerSet() -> [Owner] {
        if self != nil {
            return Array(self as! Set<Owner>)
        }
        return []
    }

    func toAngelOwnerSet() -> [AngelOwner] {
        if self != nil {
            return Array(self as! Set<AngelOwner>)
        }
        return []
    }

    func toTagSet() -> [Tag] {
        if self != nil {
            return Array(self as! Set<Tag>)
        }
        return []
    }
}
