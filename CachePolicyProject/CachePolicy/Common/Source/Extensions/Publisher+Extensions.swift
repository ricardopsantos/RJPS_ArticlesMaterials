//
//  Created by Ricardo Santos on 19/08/2020.
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

//
// MARK: - Utils
//

public extension AnyPublisher {
    static func just(_ o: Output) -> Self {
        Just<Output>(o).setFailureType(to: Failure.self).eraseToAnyPublisher()
    }
    
    static func error(_ f: Failure) -> Self {
        Fail<Output, Failure>(error: f).eraseToAnyPublisher()
    }
    
    static func empty() -> Self {
        Empty<Output, Failure>().eraseToAnyPublisher()
    }
    
    static func never() -> Self {
        Empty<Output, Failure>(completeImmediately: false).eraseToAnyPublisher()
    }
    
    func delay(seconds: TimeInterval) -> AnyPublisher<Output, Failure> {
        delay(milliseconds: seconds * 1000)
    }
    
    func delay(milliseconds: TimeInterval) -> AnyPublisher<Output, Failure> {
        let timer = Just<Void>(())
            .delay(for: .milliseconds(Int(milliseconds)), scheduler: RunLoop.current)
            .setFailureType(to: Failure.self)
        return zip(timer)
            .map { $0.0 }
            .eraseToAnyPublisher()
    }
    
}

//
// MARK: - Retry
//

public extension AnyPublisher {
    
    typealias RetryPublisherType = Driver<Bool>
    func retry(withPublisher: @autoclosure @escaping () -> RetryPublisherType,
               if condition: @escaping (Failure) -> Bool) -> AnyPublisher.RetryWithPublisherIf<Self> {
        return AnyPublisher.RetryWithPublisherIf(publisher: self,
                                                 condition: condition,
                                                 publisherBefore: withPublisher,
                                                 times: 1)
        
    }
    
    func retry(withClosure: @escaping () -> Void,
               if condition: @escaping (Failure) -> Bool,
               delay: TimeInterval = 1) -> AnyPublisher.RetryWithClosureIf<Self> {
        return AnyPublisher.RetryWithClosureIf(publisher: self,
                                               condition: condition,
                                               closure: withClosure,
                                               delay: delay,
                                               times: 1)
    }
    
    func retry(times: Int,
               if condition: @escaping (Failure) -> Bool,
               delay: TimeInterval = 1) -> AnyPublisher.RetryIf<Self> {
        return AnyPublisher.RetryIf(publisher: self,
                                    times: times,
                                    condition: condition,
                                    delay: delay)
        
    }
    
    struct RetryWithPublisherIf<P: Publisher>: Publisher {
        public typealias Output  = P.Output
        public typealias Failure = P.Failure
        let publisher: P
        let condition: (P.Failure) -> Bool
        let publisherBefore: () -> RetryPublisherType
        let times: Int
        public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            guard times > 0 else { return publisher.receive(subscriber: subscriber) }
            publisher.catch { (error: P.Failure) -> AnyPublisher<Output, Failure> in
                let result = RetryWithPublisherIf(publisher: publisher,
                                                  condition: condition,
                                                  publisherBefore: publisherBefore,
                                                  times: times - 1).eraseToAnyPublisher()
                if condition(error) {
                    return publisherBefore().eraseToAnyPublisher().flatMap { _ in
                        return result
                    }.eraseToAnyPublisher()
                }
                return result
            }.receive(subscriber: subscriber)
        }
    }
    
    struct RetryWithClosureIf<P: Publisher>: Publisher {
        public typealias Output  = P.Output
        public typealias Failure = P.Failure
        let publisher: P
        let condition: (P.Failure) -> Bool
        let closure: () -> Void
        let delay: TimeInterval
        let times: Int
        public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            guard times > 0 else { return publisher.receive(subscriber: subscriber) }
            publisher.catch { (error: P.Failure) -> AnyPublisher<Output, Failure> in
                if condition(error) {
                    closure()
                }
                return Just(1).eraseToAnyPublisher()
                    .delay(seconds: delay)
                    .eraseToAnyPublisher().flatMap { _ in
                        RetryWithClosureIf(publisher: publisher,
                                           condition: condition,
                                           closure: closure,
                                           delay: delay,
                                           times: times - 1).eraseToAnyPublisher()
                    }.eraseToAnyPublisher()
            }
                .receive(subscriber: subscriber)
        }
    }
    
    struct RetryIf<P: Publisher>: Publisher {
        public typealias Output  = P.Output
        public typealias Failure = P.Failure
        
        let publisher: P
        let times: Int
        let condition: (P.Failure) -> Bool
        let delay: TimeInterval
        public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            guard times > 0 else { return publisher.receive(subscriber: subscriber) }
            publisher.catch { (error: P.Failure) -> AnyPublisher<Output, Failure> in
                if condition(error) {
                    return Just(1).eraseToAnyPublisher()
                        .delay(seconds: delay)
                        .eraseToAnyPublisher().flatMap { _ in
                            RetryIf(publisher: publisher,
                                    times: times - 1,
                                    condition: condition,
                                    delay: delay).eraseToAnyPublisher()
                        }.eraseToAnyPublisher()
                } else {
                    return Fail(error: error).eraseToAnyPublisher()
                }
            }.receive(subscriber: subscriber)
        }
    }
}

//
// MARK: - SubscribeStrategie
//

public extension Publisher {
    
    func subscribeStrategieMainToMain() -> Publishers.ReceiveOn<Publishers.SubscribeOn<Self, DispatchQueue>, DispatchQueue> {
        subscribe(on: DispatchQueue.main).receive(on: DispatchQueue.main)
    }
    
    func subscribeStrategieGlobalToGlobal() -> Publishers.ReceiveOn<Publishers.SubscribeOn<Self, DispatchQueue>, DispatchQueue> {
        subscribe(on: DispatchQueue.global()).receive(on: DispatchQueue.global())
    }
    
    func subscribeStrategieGlobalToMain() -> Publishers.ReceiveOn<Publishers.SubscribeOn<Self, DispatchQueue>, DispatchQueue> {
        subscribe(on: DispatchQueue.global()).receive(on: DispatchQueue.main)
    }
    
    func subscribeStrategieGlobalBackgroundToMain() -> Publishers.ReceiveOn<Publishers.SubscribeOn<Self, DispatchQueue>, DispatchQueue> {
        subscribe(on: DispatchQueue.global(), options: .init(qos: .background)).receive(on: DispatchQueue.main)
    }
    
    func subscribeStrategieGlobalBackgroundToGlobal() -> Publishers.ReceiveOn<Publishers.SubscribeOn<Self, DispatchQueue>, DispatchQueue> {
        subscribe(on: DispatchQueue.global(), options: .init(qos: .background)).receive(on: DispatchQueue.global())
    }
    
    var genericError: AnyPublisher<Self.Output, Error> {
        mapError({ (error: Self.Failure) -> Error in return error }).eraseToAnyPublisher()
    }
        
    func ignoreErrorJustComplete(_ onError: ((Error) -> Void)? = nil) -> AnyPublisher<Output, Never> {
        self
            .catch({ error -> AnyPublisher<Output, Never> in
                onError?(error)
                return .empty()
            })
                .eraseToAnyPublisher()
    }
    
    func onErrorComplete() -> AnyPublisher<Output, Never> {
        self.catch({ _ -> AnyPublisher<Output, Never> in
            return .empty()
        }).eraseToAnyPublisher()
    }
    
    func onErrorComplete(withClosure: @escaping () -> Void) -> AnyPublisher<Output, Never> {
        self.catch({ e -> AnyPublisher<Output, Never> in
            withClosure()
            return .empty()
        }).eraseToAnyPublisher()
    }
}

//
// MARK: - Debug
//

public extension Publisher {
    
    func debugPublisher(file: String = #file,
                        function: String = #function,
                        id: String,
                        to stream: TextOutputStream? = nil) -> Publishers.Print<Self> {
        let filePrety = file.components(separatedBy: "/").last!
        let location = "# Publisher Debug : \(Date()) | [\(function)] @ [\(filePrety)]\n  \(id)"
        return print(location, to: stream)
    }
    
    func sampleOperator<T>(source: T) -> AnyPublisher<Self.Output, Self.Failure> where T: Publisher, T.Output: Equatable, T.Failure == Self.Failure {
        combineLatest(source)
            .removeDuplicates(by: { (first, second) -> Bool in first.1 == second.1 })
            .map { first in first.0 }
            .eraseToAnyPublisher()
    }
    
    func sinkToReceiveValue(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error): result(.failure(error))
            case .finished: _ = ()
            }
        }, receiveValue: { value in
            result(.success(value))
        })
    }
    
}

//
// MARK: - Driver
//

public typealias Driver<T> = AnyPublisher<T, Never>
public typealias BoolDriver = Driver<Bool>
extension Publisher {
    public func asBoolDriver() -> BoolDriver {
        return self.asDriver().eraseToAnyPublisher().flatMap { _ in
            Just(true).eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
    
    public func asDriver() -> Driver<Output> {
        return self.catch { _ in Empty() }
            .receive(on: RunLoop.current)
            .eraseToAnyPublisher()
    }
    
    public static func just(_ output: Output) -> Driver<Output> {
        return Just(output).eraseToAnyPublisher()
    }
    
    public static func empty() -> Driver<Output> {
        return Empty().eraseToAnyPublisher()
    }
}

//
// MARK: - ActivityTracker
//

public typealias ActivityTracker = CurrentValueSubject<Bool, Never>
public typealias FieldActivityTracker = CurrentValueSubject<(String, Bool), Never>

public extension Publisher {
    func trackActivity(_ activityTracker: ActivityTracker) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveSubscription: { _ in
            activityTracker.send(true)
        }, receiveCompletion: { _ in
            activityTracker.send(false)
        }, receiveCancel: {
            activityTracker.send(false)
        })
        .eraseToAnyPublisher()
    }
    
    func trackFieldActivity(_ activityTracker: FieldActivityTracker, key: String) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveSubscription: { _ in
            activityTracker.send((key, true))
        }, receiveCompletion: { _ in
            activityTracker.send((key, false))
        }, receiveCancel: {
            activityTracker.send((key, false))
        })
        .eraseToAnyPublisher()
    }
}

//
// MARK: - ErrorTracker
//

public typealias ErrorTracker = PassthroughSubject<Error, Never>

public extension Publisher /*where Failure: Error */{
    func trackError(_ errorTracker: ErrorTracker) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                errorTracker.send(error)
            }
        })
        .eraseToAnyPublisher()
    }
}

//
// MARK: - AnyPublisherSampleUsage
//

public class AnyPublisherSampleUsage {
    
    enum AppErrors: Error, Equatable, Hashable {
        case cacheNotFound
    }
    
    static var cacheString: String?
    static var cancelBag = CancelBag()
    
    static func functionThatCanFail() -> AnyPublisher<String, AppErrors> {
        guard cacheString != nil else {
            return Fail(error: .cacheNotFound).eraseToAnyPublisher()
        }
        return Just(cacheString!).setFailureType(to: AppErrors.self).eraseToAnyPublisher()
    }
    
    static func fixFunctionThatCanFail() -> AnyPublisher<Void, Never> {
        cacheString = "\(Date())"
        return Just(()).eraseToAnyPublisher()
    }
    
    static func exampleRetryWithClosure() -> AnyPublisher<String, AppErrors> {
        Deferred {
            functionThatCanFail()
        }.eraseToAnyPublisher().retry(withClosure: {
            cacheString = "\(Date())"
        }, if: { $0 == .cacheNotFound }, delay: 1).eraseToAnyPublisher()
    }
    
    static func exampleRetryWithPublisher() -> AnyPublisher<String, AppErrors> {
        return Deferred {
            functionThatCanFail()
        }.eraseToAnyPublisher()
            .retry(withPublisher:
                    { fixFunctionThatCanFail().asBoolDriver()
            }(), if: { $0 == .cacheNotFound })
            .eraseToAnyPublisher()
    }
    
    public static func sampleUsageRetry() {
        exampleRetryWithClosure().sinkToReceiveValue { some in
            print("### RESULT: \(some)")
        }.store(in: cancelBag)
        exampleRetryWithPublisher().sinkToReceiveValue { some in
            print("### RESULT: \(some)")
        }.store(in: cancelBag)
    }
}
