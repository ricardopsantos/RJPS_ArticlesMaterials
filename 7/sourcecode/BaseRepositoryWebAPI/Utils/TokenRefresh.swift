//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import RxCocoa
import RxSwift
//
import DevTools

func testRefreshToken() {

    let webAPI = WEBAPI()

    webAPI.asyncRequest(param: "AA") { (result) in DevTools.Log.message(result) }
    webAPI.asyncRequest(param: "BB") { (result) in DevTools.Log.message(result) }
    webAPI.asyncRequest(param: "CC") { (result) in DevTools.Log.message(result) }

    DispatchQueue.executeWithDelay(delay: 5) {
        webAPI.invalidateToken()
        webAPI.asyncRequest(param: "DD") { (result) in DevTools.Log.message(result) }
        webAPI.asyncRequest(param: "EE") { (result) in DevTools.Log.message(result) }
        webAPI.asyncRequest(param: "FF") { (result) in DevTools.Log.message(result) }
    }
}

var disposeBag: DisposeBag = DisposeBag()

class WEBAPI {
    private enum TokenState { case valid, invalid, refreshing }
    private let rxTokenState: BehaviorRelay = BehaviorRelay<TokenState>(value: .invalid)
    private let rxTokenValue: BehaviorRelay = BehaviorRelay<String>(value: "")

    func invalidateToken() { DevTools.Log.message("Token invalidated...".uppercased()); rxTokenState.accept(.invalid) }
    func asyncRequest(param: String, result: @escaping(String) -> Void) {

        func requestThatNeedsToken(_ token: String) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { result("asyncRequestA.response.[\(param)][\(token)]") }
        }

        _rxObservableGetTokenRequest.subscribe(onSuccess: { _ in
            requestThatNeedsToken(self.rxTokenValue.value)
        }).disposed(by: disposeBag)
    }

    private var _rxObservableGetTokenRequest: Single<Void> {
        return Single<Void>.create { observer -> Disposable in
            let identifier = "# TokenRefresh: "
            let endSequence = {
                DevTools.Log.message("\(identifier)Returned valid token.")
                observer(.success(()))
            }
            if self.rxTokenState.value == .valid {
                endSequence()
            } else {
                if self.rxTokenState.value == .refreshing {
                    DevTools.Log.message("\(identifier)A new Token is already refreshing. Will observe for a change....")
                    self.rxTokenState.subscribe(onNext: { state in
                        if state == .valid {
                            DevTools.Log.message("\(identifier)Theres a new token available!")
                            endSequence()
                        }
                        }).disposed(by: disposeBag)
                } else {
                    DevTools.Log.message("\(identifier)Invalid token. Will refresh...")
                    self.rxTokenState.accept(.refreshing)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if Bool.random() {
                            let newToken = "some_token_[\(Date())]"
                            DevTools.Log.message("\(identifier)New Token generated!".uppercased() + " -> " + newToken)
                            self.rxTokenValue.accept(newToken)
                            self.rxTokenState.accept(.valid)
                            endSequence()
                        } else {
                            DevTools.Log.message("\(identifier)Fail generating token!".uppercased())
                            self.rxTokenState.accept(.invalid)
                            observer(.error(NSError(domain: "error.domain.refreshing", code: 0, userInfo: nil)))
                        }
                    }
                }
            }
            return Disposables.create()
        }
        .retry(10)
    }
}
