//
//  Created by Ricardo Santos on 22/01/2021.
//

import Foundation
import Combine

public typealias AvailabilityState = NetworkinNameSpace.NetworkingUtils.RepositoryAvailabilityState

public extension NetworkinNameSpace {
    struct NetworkingUtils {
        private init() { }
        
        public enum RepositoryAvailabilityState {
            case free       // API call qeue is free
            case refreshing // API call qeue is performing
            
            fileprivate static var serviceStates: [String: CurrentValueSubject<RepositoryAvailabilityState, Never>] = [:]
            public static func lockForServiceKey(_ serviceKey: String) {
                synced(AvailabilityState.serviceStates) {
                    if AvailabilityState.serviceStates[serviceKey] == nil {
                        AvailabilityState.serviceStates[serviceKey] = .init(.refreshing)
                    } else {
                        AvailabilityState.serviceStates[serviceKey]!.value = .refreshing
                    }
                }
            }
            public static func unLockForServiceKey(_ serviceKey: String) {
                synced(AvailabilityState.serviceStates) {
                    if AvailabilityState.serviceStates[serviceKey] == nil {
                        AvailabilityState.serviceStates[serviceKey] = .init(.free)
                    } else {
                        AvailabilityState.serviceStates[serviceKey]!.value = .free
                    }
                }
            }
        }
    }
}

public typealias GenericRequestWithCacheResponse<T1: Codable, E1: Error> = AnyPublisher<T1, E1>
public extension NetworkinNameSpace.NetworkingUtils {
    static func genericRequestWithCache<T1: Codable, E1: Error, T2: Codable, E2: Error>(
        _ publisher: AnyPublisher<T2, E2>,
        _ type: T1.Type,
        _ cachePolicy: CachePolicy,
        _ serviceKey: String,
        _ serviceParams: [String],
        _ cacheManager: CodableCacheManagerProtocol = SimpleCacheManagerForCodable.shared) -> GenericRequestWithCacheResponse<T1, E1> {
            
            let lock = {
                print("\(Date()) Will load")
                AvailabilityState.lockForServiceKey(serviceKey)
            }
            
            let unlock = {
                print("\(Date()) Did load")
                AvailabilityState.unLockForServiceKey(serviceKey)
            }
            
            // Fetch for CACHED data
            func cacheDontLoad() -> GenericRequestWithCacheResponse<T1, E1> {
                if let storedModel = cacheManager.syncRetrieve(type,
                                                               key: serviceKey,
                                                               params: serviceParams) {
                    return Just(storedModel.model).setFailureType(to: E1.self).eraseToAnyPublisher()
                } else {
                    return .empty()
                }
            }
            
            // Fetch for NEW data
            func noCacheDoLoad() -> GenericRequestWithCacheResponse<T1, E1> {
                lock()
                return publisher.onErrorComplete(withClosure: { unlock() })
                    .flatMap({ model -> GenericRequestWithCacheResponse<T1, E1> in
                        cacheManager.syncStore(model, key: serviceKey, params: serviceParams, timeToLiveMinutes: nil)
                        unlock()
                        if let model = model as? T1 {
                            return Just(model).setFailureType(to: E1.self).eraseToAnyPublisher()
                        } else {
                            return .empty()
                        }
                    })
                    .catch({ error -> GenericRequestWithCacheResponse<T1, E1> in
                        unlock()
                        return Fail(error: error).eraseToAnyPublisher()
                    }).eraseToAnyPublisher()
            }
            
            // Fetch for NEW data, OR wait for cache data to change and
            func noCacheDoLoadOrWait() -> GenericRequestWithCacheResponse<T1, E1> {
                switch AvailabilityState.serviceStates[serviceKey]?.value ?? .free {
                case .free: return noCacheDoLoad()
                case .refreshing: return awaitForCache()
                }
            }
            
            // Theres allready a request on the way. Lets wait for it to end and then return the cached value
            func awaitForCache() -> GenericRequestWithCacheResponse<T1, E1> {
                return AvailabilityState.serviceStates[serviceKey]!.filter({ $0 == .free })
                    .flatMap { _ in return
                        cacheDontLoad()
                    }.eraseToAnyPublisher()
            }
                        
            switch cachePolicy {
            case .ignoringCache:
                return noCacheDoLoadOrWait()
            case .cacheElseLoad:
                return cacheDontLoad().catch { _ -> GenericRequestWithCacheResponse<T1, E1> in
                    return noCacheDoLoadOrWait()
                }.eraseToAnyPublisher()
            case .cacheAndLoad:
                let cacheDontLoad = cacheDontLoad().onErrorComplete().setFailureType(to: E1.self).eraseToAnyPublisher()
                return Publishers.Merge(cacheDontLoad, noCacheDoLoadOrWait()).eraseToAnyPublisher()
            case .cacheDontLoad:
                return cacheDontLoad()
            }
        }
}
