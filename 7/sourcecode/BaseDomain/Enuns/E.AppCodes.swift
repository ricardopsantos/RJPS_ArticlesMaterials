//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation

// This codes can be translated into
// 1 - DevTeam messages like `AppCodes.invalidURL.localisedMessageForDevTeam`,
// 2 - App/view messages like `AppCodes.invalidURL.localisedMessageForView`
// 3 - Error like `AppCodes.invalidCredentials.toError`
// and this way have a clean and centralised way to related Errors that we can thow and then turn into App/view messages to present to the user

public enum AppCodes: Int {
    case noInternet = 1000
    case notImplemented
    case notPredicted
    case parsingError
    case ignored
    case invalidURL
    case dequeueReusableCellFail
    case unknownError
    case referenceLost
    case notFound
    case invalidCredentials
}
