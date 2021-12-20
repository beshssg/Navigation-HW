//
//  Pluralization.swift
//  NavigationNET
//
//  Created by beshssg on 20.12.2021.
//

import UIKit

class Pluralization {
    enum Category {
        case one
        case few
        case many
        case other
    }
}

struct PluralizableString {
    var one: String
    var few: String
    var many: String
}
