//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit
//
import RxSwift
import RxCocoa
import RJSLibUFNetworking
import RJSLibUFStorage
//
import BaseRepositories
import BaseConstants
import PointFreeFunctions
import BaseCore
import BaseDomain
import DomainGalleryApp
import Factory

public class GalleryAppWebAPIUseCase: GenericUseCase, GalleryAppWebAPIUseCaseProtocol {

    public override init() { super.init() }

    public var networkRepository: GalleryAppNetWorkRepositoryProtocol!      // resolved at class DIAssemblyContainerGalleryApp
    public var hotCacheRepository: HotCacheRepositoryProtocol!              // resolved at class DIAssemblyContainerGalleryApp
    public var coldKeyValuesRepository: KeyValuesStorageRepositoryProtocol! // resolved at class DIAssemblyContainerGalleryApp
    public var apiCache: APICacheManagerProtocol!                           // resolved at class DIAssemblyContainerGalleryApp

    private static var cacheTTL = 60 * 24 // 24h cache

    // Will
    // - Manage the requests queue
    // - Call the API
    // - Manage the Cache
    // (Converting Dto entities to Model entities will be done above on the worker)
    public func imageInfo(_ request: GalleryAppRequests.ImageInfo, cacheStrategy: CacheStrategy) -> Observable<GalleryAppResponseDto.ImageInfo> {
        let cacheKey = "\(#function).\(request)"

        var block: Observable<GalleryAppResponseDto.ImageInfo> {
            var apiObserver: Observable<GalleryAppResponseDto.ImageInfo> {
                return Observable<GalleryAppResponseDto.ImageInfo>.create { observer in
                    self.networkRepository.imageInfo(request) { [weak self] (result) in
                        switch result {
                        case .success(let some) :
                            observer.on(.next(some.entity))
                            self?.apiCache.save(some.entity.toDomain, key: cacheKey, params: [], lifeSpam: Self.cacheTTL)
                        case .failure(let error):
                            observer.on(.error(error))
                        }
                        observer.on(.completed)
                    }
                    return Disposables.create()
                }.catchError { (_) -> Observable<GalleryAppResponseDto.ImageInfo> in
                    // Sometimes the API fail. Return empty object to terminate the operation
                    Observable.just(GalleryAppResponseDto.ImageInfo())
                }
            }

            // Cache

            let cacheObserver = apiCache.genericCacheObserver(GalleryAppResponseDto.ImageInfo.self,
                                                              cacheKey: cacheKey,
                                                              keyParams: [],
                                                              apiObserver: apiObserver.asSingleSafe())

            // Handle by cache strategy

            switch cacheStrategy {
            case .noCacheLoad: return apiObserver.asObservable()
            case .cacheElseLoad: return cacheObserver.asObservable()
            case .cacheAndLoad: return Observable.merge(cacheObserver, apiObserver.asObservable() )
            case .cacheNoLoad: fatalError("Not safe!")
            }
        }

        return Observable<GalleryAppResponseDto.ImageInfo>.create { observer in
            let operation = APIRequestOperation(block: block)
            OperationQueueManager.shared.add(operation)
            operation.completionBlock = {
                if operation.isCancelled || operation.noResultAvailable {
                    observer.on(.error(Factory.Errors.with(appCode: .notPredicted)))
                } else {
                    observer.on(.next(operation.result!))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }

    }

    // Will
    // - Call the API
    // - Manage the Cache
    // (Converting Dto entities to Model entities will be done above on the worker)
    public func search(_ request: GalleryAppRequests.Search, cacheStrategy: CacheStrategy) -> Observable<GalleryAppResponseDto.Search> {
        let cacheKey = "\(#function).\(request)"

        // API
        var apiObserver: Observable<GalleryAppResponseDto.Search> {
            return Observable<GalleryAppResponseDto.Search>.create { observer in
                self.networkRepository.search(request) { [weak self] (result) in
                    switch result {
                    case .success(let some) :
                        observer.on(.next(some.entity))
                        self?.apiCache.save(some.entity.toDomain, key: cacheKey, params: [], lifeSpam: Self.cacheTTL)
                    case .failure(let error): observer.on(.error(error))
                    }
                    observer.on(.completed)
                }
                return Disposables.create()
            }
        }
        
        // Cache
        let cacheObserver = apiCache.genericCacheObserver(GalleryAppResponseDto.Search.self,
                                                          cacheKey: cacheKey,
                                                          keyParams: [],
                                                          apiObserver: apiObserver.asSingleSafe())

        // Handle by cache strategy

        switch cacheStrategy {
        case .noCacheLoad: return apiObserver.asObservable()
        case .cacheElseLoad: return cacheObserver.asObservable()
        case .cacheAndLoad: return Observable.merge(cacheObserver, apiObserver.asObservable() )
        case .cacheNoLoad: fatalError("Not safe!")
        }
    }
}
