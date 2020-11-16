//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import UIKit
import Foundation
//
import RxSwift
import RxCocoa
//
import DevTools

// MARK: - ignoreNil

public protocol OptionalTypeProtocol {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}

extension Optional: OptionalTypeProtocol {
    public var optional: Wrapped? { return self }
}

public extension Observable where Element: OptionalTypeProtocol {
    func ignoreNil() -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Observable<Element.Wrapped>.just($0) } ?? Observable<Element.Wrapped>.empty()
        }
    }
}

// MARK: - Erros handling

public extension PrimitiveSequence where Trait == CompletableTrait, Element == Never {

    func ignoreError() -> Completable {
        return catchError { (_: Error) -> Completable in
            return Completable.empty()
        }
    }

    func mapError(swallow: Bool) -> Completable {
        return catchError { (error: Error) -> Completable in
            if swallow {
                DevTools.Log.error("Error shallowed on RxChain")
                return Completable.empty()
            } else {
                DevTools.Log.error("Error shallowed on RxChain")
                return Completable.error(error)
            }
        }
    }
}
// MARK: - Reactive.UIButton

extension Reactive where Base == UIButton {

    // Same as rx.Tap but avoid double repeated taps
    public func tapSmart(_ disposeBag: DisposeBag, _ timeout: TimeInterval = 1) -> Observable<Void> {
        return tap
            .do(onNext: { [base] _ in
                base.addPulse()
                base.isUserInteractionEnabled = false
                Observable<Void>
                    .just(())
                    .delay(timeout, scheduler: MainScheduler.instance)
                    .do(onNext: {
                        base.isUserInteractionEnabled = true
                    })
                    .subscribe()
                    .disposed(by: disposeBag)
            })
    }
}

// MARK: - ObservableType

extension ObservableType {
/*
    func subscribeNext(bag: DisposeBag, next: @escaping (Self.Element) -> Void) {
        subscribe(onNext: next).disposed(by: bag)
    }

    func subscribeNext(bag: DisposeBag, next: @escaping (Self.Element) -> Void, error: @escaping (Error) -> Void) {
        subscribe(onNext: next, onError: error).disposed(by: bag)
    }
*/
    public func asSingleSafe() -> Single<Element> {
        return take(1)
            .asSingle()
    }
    
    public func asMaybeSafe() -> Maybe<Element> {
        return take(1)
            .asMaybe()
    }
}

// MARK: - ObservableType

extension ObservableType where Self.Element == Void {
    func subscribeNext(bag: DisposeBag, next: @escaping () -> Void) {
        subscribe(onNext: { _ in
            next()
        }).disposed(by: bag)
    }
}

// MARK: - Logs

extension ObservableType {

    public func log(_ identifier: String,
                    trimOutput: Bool = false,
                    file: StaticString = #file,
                    line: UInt = #line,
                    function: StaticString = #function)
        -> Observable<Element> {
            self.do(onNext: { (element) in
                let maxEventTextLength = 40
                let eventText = "\(element)"

                let eventNormalized = (eventText.count > maxEventTextLength) && trimOutput
                    ? String(eventText.prefix(maxEventTextLength / 2)) + "..." + String(eventText.suffix(maxEventTextLength / 2))
                    : eventText
                writeToLog(identifier: identifier, event: "next", eventText: "(\(eventNormalized))", file: "\(file)", line: Int(line), function: "\(function)", isError: false)
            }, onError: { (error) in
                writeToLog(identifier: identifier, event: "error", eventText: "(\(error))", file: "\(file)", line: Int(line), function: "\(function)", isError: true)
            }, onCompleted: {
                writeToLog(identifier: identifier, event: "completed", eventText: "", file: "\(file)", line: Int(line), function: "\(function)", isError: false)
            }, onSubscribe: {
                writeToLog(identifier: identifier, event: "subscribe", eventText: "", file: "\(file)", line: Int(line), function: "\(function)", isError: false)
            }, onSubscribed: {
                writeToLog(identifier: identifier, event: "subscribed", eventText: "", file: "\(file)", line: Int(line), function: "\(function)", isError: false)
            }, onDispose: {
                writeToLog(identifier: identifier, event: "dispose", eventText: "", file: "\(file)", line: Int(line), function: "\(function)", isError: false)
            })
    }

}

extension PrimitiveSequenceType where Trait == CompletableTrait, Element == Never {

    public func log(_ identifier: String,
                    trimOutput: Bool = false,
                    file: StaticString = #file,
                    line: UInt = #line,
                    function: StaticString = #function)
        -> Completable {
            return self.do(onError: { (error) in
                writeToLog(identifier: identifier, event: "error", eventText: "(\(error))", file: "\(file)", line: Int(line), function: "\(function)", isError: true)
            }, onCompleted: {
                writeToLog(identifier: identifier, event: "completed", eventText: "", file: "\(file)", line: Int(line), function: "\(function)", isError: false)
            }, onSubscribe: {
                writeToLog(identifier: identifier, event: "subscribe", eventText: "", file: "\(file)", line: Int(line), function: "\(function)", isError: false)
            }, onSubscribed: {
                writeToLog(identifier: identifier, event: "subscribed", eventText: "", file: "\(file)", line: Int(line), function: "\(function)", isError: false)
            }, onDispose: {
                writeToLog(identifier: identifier, event: "dispose", eventText: "", file: "\(file)", line: Int(line), function: "\(function)", isError: false)
            })
    }
}

extension PrimitiveSequenceType where Trait == SingleTrait {

    public func log(_ identifier: String, trimOutput: Bool = true, file: StaticString = #file, line: UInt = #line, function: StaticString = #function)
        -> Single<Element> {
            self.do(onSuccess: { (element) in
                let maxEventTextLength = 40
                let eventText = "\(element)"

                let eventNormalized = (eventText.count > maxEventTextLength) && trimOutput
                    ? String(eventText.prefix(maxEventTextLength / 2)) + "..." + String(eventText.suffix(maxEventTextLength / 2))
                    : eventText
                writeToLog(identifier: identifier, event: "success", eventText: "(\(eventNormalized))", file: "\(file)", line: Int(line), function: "\(function)", isError: false)
            }, onError: { (error) in
                writeToLog(identifier: identifier, event: "error", eventText: "(\(error))", file: "\(file)", line: Int(line), function: "\(function)", isError: true)
            }, onSubscribe: {
                writeToLog(identifier: identifier, event: "subscribe", eventText: "", file: "\(file)", line: Int(line), function: "\(function)", isError: false)
            }, onSubscribed: {
                writeToLog(identifier: identifier, event: "subscribed", eventText: "", file: "\(file)", line: Int(line), function: "\(function)", isError: false)
            }, onDispose: {
                writeToLog(identifier: identifier, event: "dispose", eventText: "", file: "\(file)", line: Int(line), function: "\(function)", isError: false)
            })
    }
}

private func writeToLog(identifier: String,
                        event: String,
                        eventText: String,
                        file: String,
                        line: Int,
                        function: String,
                        isError: Bool) {
    if isError {
        DevTools.Log.error("[Rx] \(identifier) -> \(event)\(eventText)", function: function, file: file, line: line)
    } else {
//        DevTools.Log.message("[Rx] \(identifier) -> \(event)\(eventText)", function: function, file: file, line: line)
    }
}
