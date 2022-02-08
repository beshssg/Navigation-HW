//
//  LoginInspector.swift
//  NavigationNET
//
//  Created by beshssg on 12.09.2021.
//

import UIKit
import Firebase

class LoginInspector: LoginViewControllerDelegate {
    
    private(set) var login = "SnakeEyes"
    private(set) var password = "12345"
    
    func loginControllerDidValidateCredentials(_ loginController: LoginViewController, completion: @escaping CredentialsVerificationCompletionBlock) {
        guard login == self.login, !login.isEmpty else {
            completion(.failure(CredentialsError.emptyLogin))
            return
        }
        guard password == self.password, !password.isEmpty else {
            completion(.failure(CredentialsError.emptyPassword))
            return
        }
        Auth.auth().signIn(withEmail: login, password: password) { (result, error) in
            if let error = error as NSError?, let code = AuthErrorCode(rawValue: error.code) {
                switch code {
                case .userNotFound:
                    completion(.success(false))
                    return
                default:
                    completion(.failure(error))
                }
                return
            }
            completion(.success(true))
        }
    }
    
    func loginControllerDidRegisterUser(_ loginController: LoginViewController, completion: @escaping CredentialsVerificationCompletionBlock) {
        guard login == self.login, !login.isEmpty else {
            completion(.failure(CredentialsError.emptyLogin))
            return
        }
        guard password == self.password, !password.isEmpty else {
            completion(.failure(CredentialsError.emptyPassword))
            return
        }
        Auth.auth().createUser(withEmail: login, password: password) { (result, error) in
            if let error = error as NSError?, let _ = AuthErrorCode(rawValue: error.code) {
                print(error)
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    
   
    
    func checkerLogin(emailOrPhone: String, password: String) -> Bool {
        return Checker.shared.check(emailOrPhone: emailOrPhone, password: password)
    }
}


