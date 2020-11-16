//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Swinject
import RJSLibUFNetworking
//
import BaseDomain
import DomainCarTrack
import BaseRepositories
import BaseRepositoryWebAPI
import BaseCore
import DevTools
import CoreCarTrack
import RepositoryWebAPICartrack

//
// MARK: - Protocols references sugar
//

struct DIAssemblyContainerCartTrackProtocols {
    static let carTrackAppWorker                 = CarTrackWorkerProtocol.self
    static let carTrackAPIUseCase                = CarTrackWebAPIUseCaseProtocol.self             // UseCase - WebAPI
    static let carTrackGenericAppBusinessUseCase = CarTrackGenericAppBusinessUseCaseProtocol.self // UseCase - Generic
    static let carTrack_NetWorkRepository        = CarTrackNetWorkRepositoryProtocol.self         // Repository - WebAPI
}

//
// MARK: - Resolvers
//

public class CarTrackResolver {
    private init() { }
    public static let worker = DIAssemblerScenesCarTrack.assembler.resolver.resolve(DIAssemblyContainerCartTrackProtocols.carTrackAppWorker.self)
}

//
// MARK: - Assembly Container
//

final class DIAssemblyContainerCarTrack: Assembly {
    func assemble(container: Container) {

        if DevTools.isMockApp {
            container.autoregister(DIAssemblyContainerCartTrackProtocols.carTrack_NetWorkRepository,
                                   initializer: WebAPI.CarTrack.NetWorkRepositoryMock.init).inObjectScope(.container)
        } else {
            container.autoregister(DIAssemblyContainerCartTrackProtocols.carTrack_NetWorkRepository,
                                   initializer: WebAPI.CarTrack.NetWorkRepository.init).inObjectScope(.container)
        }

        // worker
        container.register(DIAssemblyContainerCartTrackProtocols.carTrackAppWorker) { resolver in
            let w = CarTrackWorker()
            w.webAPIUSeCase  = resolver.resolve(DIAssemblyContainerCartTrackProtocols.carTrackAPIUseCase)
            w.genericUseCase  = resolver.resolve(DIAssemblyContainerCartTrackProtocols.carTrackGenericAppBusinessUseCase)
            return w
        }

        container.register(DIAssemblyContainerCartTrackProtocols.carTrackAPIUseCase) { resolver in
            let uc = CarTrackAPIUseCase()
            uc.networkRepository       = resolver.resolve(DIAssemblyContainerCartTrackProtocols.carTrack_NetWorkRepository)
            uc.coldKeyValuesRepository = DIRootAssemblyResolver.coldKeyValuesRepository
            uc.hotCacheRepository      = DIRootAssemblyResolver.hotCacheRepository
            uc.apiCache                = DIRootAssemblyResolver.apiCacheRepository
            return uc
        }

        container.register(DIAssemblyContainerCartTrackProtocols.carTrackGenericAppBusinessUseCase) { _ in
            let uc = CarTrackGenericAppBusinessUseCase()
            uc.hotCacheRepository      = DIRootAssemblyResolver.hotCacheRepository
            uc.hotCacheRepository      = DIRootAssemblyResolver.hotCacheRepository
            return uc
        }
    }
}
