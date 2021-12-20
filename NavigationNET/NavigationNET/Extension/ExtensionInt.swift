//
//  ExtensionInt.swift
//  NavigationNET
//
//  Created by beshssg on 20.12.2021.
//

import UIKit

extension Int {
    func pluralForm(of word: PluralizableString) -> String {
        return Double(self).pluralForm(of: word)
    }
}

extension Double {
    private func pluralCategory() -> Pluralization.Category {
        let i = Int(self)
        var v = 0
        if self != Double(Int(self)) {
            v = String(self).count - String(i).count - 1
        }
     
        if (v == 0 && (i % 10 == 1) && (i % 100 != 11)) {
            return .one
        } else if (v == 0 && (2...4).contains(i % 10) && !(12...14).contains(i % 100)) {
            return .few
        } else if ( (v == 0 && i % 10 == 0) || (v == 0 && (5...9).contains(i % 10)) || (v == 0 && (11...14).contains(i % 100)) ) {
            return .many
        } else {
            return .other
        }
    }
    
    func pluralForm(of word: PluralizableString) -> String {
        var rounded: String
        if self == Double(Int(self)) {
            rounded = String(Int(self))
        } else {
            rounded = String(Double((self * 100.0).rounded() / 100.0))
        }
        switch self.pluralCategory() {
        case .one:
            return "\(rounded) \(word.one)"
        case .few:
            return "\(rounded) \(word.few)"
        case .many:
            return "\(rounded) \(word.many)"
        case .other:
            return "\(rounded) \(word.few)"
        }
    }
}
