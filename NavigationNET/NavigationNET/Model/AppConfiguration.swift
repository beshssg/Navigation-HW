//
//  AppConfiguration.swift
//  NavigationNET
//
//  Created by beshssg on 14.11.2021.
//

import UIKit

enum AppConfiguration: String {
    static let baseUrl = "http://swapi.dev/api"
    
    case films = "/films/3/"
    case vehicles = "/vehicles/14/"
    case starships = "/starships/5/"

    static func randomize() -> AppConfiguration {
        var appConfiguration: AppConfiguration

        let randomSeed = Int.random(in: 0...2)
        switch randomSeed {
        case 0:
            appConfiguration = .films
        case 1:
            appConfiguration = .vehicles
        default:
            appConfiguration = .starships
        }

        return appConfiguration
    }
}

enum NetworkError: LocalizedError {
    case invalidURL
    case badResponse
    case invalidData

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Данный URL не является валидным"
        case .badResponse:
            return "Не получен валидный ответ от сервера"
        case .invalidData:
            return "Не удалось распознать ответ от сервера"
        }
    }
}
