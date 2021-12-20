//
//  NetworkManager.swift
//  NavigationNET
//
//  Created by beshssg on 14.11.2021.
//

import UIKit

struct NetworkService {
    static func makeDataTask(with url: URL, completion: ((Result<(HTTPURLResponse, Data), Error>) -> Void)? = nil) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let mimeType = response.mimeType,
                  mimeType.hasSuffix("json"),
                  let data = data else {
                      completion?(.failure(NetworkError.badResponse))
                      return
                  }
               completion?(.success((response, data)))
           }
    }
    static func startDataTask(with url: URL, completion: ((Result<(HTTPURLResponse, Data), Error>) -> Void)? = nil) {
            let dataTask = NetworkService.makeDataTask(with: url, completion: completion)
            dataTask.resume()
    }
}

extension Data {
    var prettyJson: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding:.utf8) else { return nil }

        return prettyPrintedString
    }
    
    func toObject() throws -> [String: Any]? {
        return try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? [String: Any]
    }
}
