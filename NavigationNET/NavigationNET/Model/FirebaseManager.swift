//
//  FirebaseManager.swift
//  NavigationNET
//
//  Created by beshssg on 30.12.2021.
//

import UIKit
import Firebase

enum CredentialsError: LocalizedError {
    case emptyLogin
    case emptyPassword
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .emptyLogin:
            return "Логин не может быть пустым"
        case .emptyPassword:
            return "Пароль не может быть пустым"
        case .unknown:
            return "Произошла неизвестная ошибка"
        }
    }
}

typealias CredentialsVerificationCompletionBlock = (Result<Bool, Error>) -> Void
