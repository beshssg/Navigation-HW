//
//  AudioTrack.swift
//  NavigationNET
//
//  Created by beshssg on 21.10.2021.
//

import UIKit

enum Filetype: String {
    case mp3 = "mp3"
}

struct AudioTrack {
    var artist: String
    var title: String
    var filename: String
    var filetype: Filetype
}
