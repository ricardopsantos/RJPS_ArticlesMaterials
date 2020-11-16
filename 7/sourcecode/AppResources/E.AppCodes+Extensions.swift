//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import Foundation
//
import BaseDomain

public extension AppCodes {

    //
    // For Dev Team
    //
    var localisedMessageForDevTeam: String {
        switch self {
        case .noInternet              : return "Dev : No internet"
        case .invalidURL              : return "Dev : Invalid url"
        case .notImplemented          : return "Dev : Not implemented"
        case .notPredicted            : return "Dev : Not predicted"
        case .parsingError            : return "Dev : Parse error"
        case .ignored                 : return "Dev : Ignored"
        case .dequeueReusableCellFail : return "Dev : dequeueReusableCellFail"
        case .unknownError            : return "Dev : Unknown error"
        case .referenceLost           : return "Dev : Reference lost"
        case .notFound                : return "Dev : Reference lost"
        case .invalidCredentials      : return "Dev : Invalid Credentials"
        }
    }

    //
    // For end users
    //
    var localisedMessageForView: String {
        switch self {
        case .noInternet              : return Messages.noInternet.localised
        case .invalidURL              : return Messages.invalidURL.localised
        case .invalidCredentials      : return Messages.invalidCredentials.localised

        case .notFound                : return Messages.defaultErrorMessage
        case .notImplemented          : return Messages.defaultErrorMessage
        case .notPredicted            : return Messages.defaultErrorMessage
        case .parsingError            : return Messages.defaultErrorMessage
        case .ignored                 : return Messages.defaultErrorMessage
        case .dequeueReusableCellFail : return Messages.defaultErrorMessage
        case .unknownError            : return Messages.defaultErrorMessage
        case .referenceLost           : return Messages.defaultErrorMessage
        }
    }

}
