//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation

// Shortcut for common app messages
public enum Messages: Int {
    case alert = 0
    case noInternet
    case pleaseTryAgainLater
    case pleaseWait
    case dismiss
    case ok
    case success
    case no
    case yes
    case details
    case invalidURL
    case userName
    case password
    case login
    case invalidPassword
    case invalidEmail
    case invalidCredentials
    case welcome
    case email
    case noRecords
    case search
    case select
    case category
    case `description`

    public static var defaultErrorMessage: String {
        return Messages.pleaseTryAgainLater.localised
    }

    public var localised: String {
        switch self {
        case .search: return AppResources.get("Search")
        case .noRecords: return AppResources.get("No Records")
        case .pleaseWait: return AppResources.get("Please wait")
        case .email: return AppResources.get("Email")
        case .welcome: return AppResources.get("Welcome")
        case .userName: return AppResources.get("Username")
        case .password: return AppResources.get("Password")
        case .invalidPassword: return AppResources.get("Invalid password")
        case .login: return AppResources.get("Login")
        case .noInternet: return AppResources.get("No Internet connection")
        case .pleaseTryAgainLater: return AppResources.get("Please try again latter")
        case .dismiss: return  AppResources.get("Dismiss")
        case .alert: return AppResources.get("Alert")
        case .ok: return AppResources.get("OK")
        case .yes: return AppResources.get("Yes")
        case .success: return AppResources.get("Success")
        case .no: return AppResources.get("NO")
        case .details: return AppResources.get("Details")
        case .invalidURL: return AppResources.get("Invalid URL")
        case .invalidEmail: return AppResources.get("Invalid email")
        case .invalidCredentials: return AppResources.get("Invalid user credentials")
        case .select: return AppResources.get("Select")
        case .category: return AppResources.get("Category")
        case .description: return AppResources.get("Description")
        }
    }

    public static func messageWith(error: Error) -> String {
        return pleaseTryAgainLater.localised
    }
}
