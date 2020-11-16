//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright (c) 2020 Ricardo P Santos. All rights reserved.
//

import UIKit
import Foundation
//
import RxCocoa
import RxSwift
import RxDataSources
//
import BaseConstants
import AppTheme
import Designables
import DevTools
import BaseDomain
import Extensions
import PointFreeFunctions
import BaseUI
import DomainGalleryApp

//
// MARK: - Interactor (Business Logic)
//

protocol GalleryAppS1BusinessLogicProtocol: BaseInteractorVIPMandatoryBusinessLogicProtocol {
    // Naming convention : func request__XXX__(viewModel: VM.GalleryAppS1.__XXX__.Request)
    func requestScreenInitialState()
    func requestSearchByTag(request: VM.GalleryAppS1.SearchByTag.Request)
    func requestLoadMore(request: VM.GalleryAppS1.LoadMore.Request)
}

//
// MARK: - Presenter (Presentation Logic)
//

protocol GalleryAppS1PresentationLogicProtocol: BasePresenterVIPProtocol {
    // Naming convention : func present__XXX__(response: VM.GalleryAppS1.__XXX__.Response)
    func presentScreenInitialState(response: VM.GalleryAppS1.ScreenInitialState.Response)
    func presentSearchByTag(response: VM.GalleryAppS1.SearchByTag.Response)
    func presentLoadMore(response: VM.GalleryAppS1.LoadMore.Response)
}

//
// MARK: - ViewController (Display Logic)
//

protocol GalleryAppS1DisplayLogicProtocol: BaseViewControllerVIPProtocol {
    // Naming convention : func display__XXX__(viewModel: VM.GalleryAppS1.__XXX__.ViewModel)
    func displayScreenInitialState(viewModel: VM.GalleryAppS1.ScreenInitialState.ViewModel)
    func displaySearchByTag(viewModel: VM.GalleryAppS1.SearchByTag.ViewModel)
    func displayLoadMore(viewModel: VM.GalleryAppS1.LoadMore.ViewModel)
}

//
// MARK: - Router (Routing Logic)
//

// Routing Logic Protocol - all the methods used for routing are kept under this protocol.
protocol GalleryAppS1RoutingLogicProtocol {
    // Naming convention : func routeTo__XXX__MaybeSomeExtraInfo()
}

//
// MARK: - Models
//

// Other Models

extension VM {
    enum GalleryAppS1 {

        struct LoadMore {
            private init() {}
            struct Request { /* ViewController -> Interactor */
            }
            struct Response { /* Interactor -> Presenter */
                let photos: [GalleryAppModel.Search.Photo]
            }
            struct ViewModel { /* Presenter -> ViewController */
                let dataSource: [VM.GalleryAppS1.TableItem]
            }
        }

        struct SearchByTag {
            private init() {}
            struct Request { /* ViewController -> Interactor */
                let tag: String
                //let page: Int
            }
            struct Response { /* Interactor -> Presenter */
                let searchValue: String
                let photos: [GalleryAppModel.Search.Photo]
            }
            struct ViewModel { /* Presenter -> ViewController */
                let searchValue: String
                let dataSource: [VM.GalleryAppS1.TableItem]
            }
        }

        struct ScreenInitialState {
            private init() {}
            struct Request {}
            struct Response {
                let photos: [GalleryAppModel.Search.Photo]
            }
            struct ViewModel {
                let dataSource: [VM.GalleryAppS1.TableItem]
            }
        }
    }
}

extension VM.GalleryAppS1 {
    struct TableItem: IdentifiableType, Hashable {

        public typealias Identity = String
        public var identity: String { return id }

        let enabled: Bool
        let image: String
        let title: String
        let subtitle: String
        let id: String

        init(enabled: Bool,
             image: String,
             title: String,
             subtitle: String,
             id: String) {
            self.enabled = enabled
            self.image = image
            self.title = title
            self.subtitle = subtitle
            self.id = id
        }
    }
}
