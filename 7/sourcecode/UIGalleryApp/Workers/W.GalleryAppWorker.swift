//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import UIKit
import Foundation
import SwiftUI
//
import RxSwift
import RxCocoa
import RJSLibUFNetworking
//
import BaseConstants
import DevTools
import Extensions
import PointFreeFunctions
import Factory
import AppResources
import BaseCore
import BaseDomain
import DomainGalleryApp

//
// The worker do the bridge between the Shenes and the UseCases
//

public protocol GalleryAppWorkerProtocol {
    var webAPIUSeCase: GalleryAppWebAPIUseCaseProtocol! { get set }
    var genericUseCase: GalleryAppGenericBusinessUseCaseProtocol! { get set }

    func search(_ request: GalleryAppRequests.Search, cacheStrategy: CacheStrategy) -> Observable<GalleryAppModel.Search>
    func imageInfoZip(_ request: GalleryAppRequests.ImageInfo, cacheStrategy: CacheStrategy) -> Observable<(GalleryAppModel.ImageInfo, UIImage)>
}

// MARK: - GalleryAppWorker

public class GalleryAppWorker {
    public var webAPIUSeCase: GalleryAppWebAPIUseCaseProtocol!           // resolved at class DIAssemblyContainerGalleryApp
    public var genericUseCase: GalleryAppGenericBusinessUseCaseProtocol! // resolved at class DIAssemblyContainerGalleryApp
}

// MARK: - GalleryAppWorkerProtocol

extension GalleryAppWorker: GalleryAppWorkerProtocol {

    public func search(_ request: GalleryAppRequests.Search, cacheStrategy: CacheStrategy) -> Observable<GalleryAppModel.Search> {
        // Map Dto -> Model
        return webAPIUSeCase.search(request, cacheStrategy: cacheStrategy)
            .flatMap { (result) -> Observable<GalleryAppModel.Search> in
                if let domain = result.toDomain {
                    return Observable.just(domain)
                } else {
                    throw Factory.Errors.with(appCode: .parsingError)
                }
        }
    }

    public func imageInfoZip(_ request: GalleryAppRequests.ImageInfo, cacheStrategy: CacheStrategy) -> Observable<(GalleryAppModel.ImageInfo, UIImage)> {
        let observerA = imageInfo(request, cacheStrategy: cacheStrategy)
        let observerB = observerA.flatMapLatest { (some) -> Observable<UIImage> in
            return self.genericUseCase.download(some)
        }
        return Observable.zip(observerA, observerB)
    }
}

// MARK: - Private

private extension GalleryAppWorker {
    func imageInfo(_ request: GalleryAppRequests.ImageInfo, cacheStrategy: CacheStrategy) -> Observable<GalleryAppModel.ImageInfo> {
        // Map Dto -> Model
        return webAPIUSeCase.imageInfo(request, cacheStrategy: cacheStrategy)
            .flatMap { (result) -> Observable<GalleryAppModel.ImageInfo> in
            if let domain = result.toDomain {
                return Observable.just(domain)
            } else {
                throw Factory.Errors.with(appCode: .parsingError)
            }
        }
    }
}
