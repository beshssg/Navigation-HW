//
//  AppDelegate.swift
//  NavigationNET
//
//  Created by beshssg on 29.08.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var appConfiguration: AppConfiguration?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        appConfiguration = AppConfiguration.randomize()
        fetchData()
        
        FirebaseApp.configure()
        
        return true
    }
    
    private func fetchData() {
            guard let appConfiguration = appConfiguration,
                  let baseUrl = URL(string: AppConfiguration.baseUrl) else { return }
        
        let apiUrl = baseUrl.appendingPathComponent(appConfiguration.rawValue)
            
        print("Fetching data from \(apiUrl)")
        
        NetworkService.startDataTask(with: apiUrl) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            
            case .success(let (response, data)):
                print("Received data:")
                
                if let humanReadable = data.prettyJson { print(humanReadable) }
                
                print("Status code: \(response.statusCode)")
                
                print("All header fields:")
                
                response.allHeaderFields.forEach { print("    \($0): \($1)") }
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

