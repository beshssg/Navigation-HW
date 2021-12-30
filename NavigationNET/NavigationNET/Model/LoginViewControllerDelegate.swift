//
//  LoginViewControllerDelegate.swift
//  NavigationNET
//
//  Created by beshssg on 12.09.2021.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func checkerLogin(emailOrPhone: String, password: String) -> Bool
    func loginControllerDidValidateCredentials(_ loginController: LoginViewController, completion: @escaping CredentialsVerificationCompletionBlock)
    func loginControllerDidRegisterUser(_ loginController: LoginViewController, completion: @escaping CredentialsVerificationCompletionBlock)
    
}

protocol LoginFactory {
    func createInspector() -> LoginViewControllerDelegate
}
