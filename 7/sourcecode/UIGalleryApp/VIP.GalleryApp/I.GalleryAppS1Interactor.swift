//
//  Created by Ricardo Santos
//  Copyright (c) 2020 Ricardo P Santos. All rights reserved.
//

import UIKit
import Foundation
//
import RxCocoa
import RxSwift
import TinyConstraints
//
import BaseConstants
import AppTheme
import Designables
import DevTools
import BaseDomain
import Extensions
import PointFreeFunctions
import BaseUI
import AppResources
import Factory
import DomainGalleryApp

//
// Interactor will fetch the Domain objects, and return that response
// to the Presenter. The Presenter will parse then into ViewModel objects
//
// The interactor contains your app’s business logic. The user taps and swipes in your UI in
// order to interact with your app. The view controller collects the user inputs from the UI
// and passes it to the interactor. It then retrieves some models and asks some workers to do the work.
//

extension I {
    class GalleryAppS1Interactor: BaseInteractorVIP {

        deinit {
            DevTools.Log.logDeInit("\(GalleryAppS1Interactor.self) was killed")
            NotificationCenter.default.removeObserver(self)
        }
        var presenter: GalleryAppS1PresentationLogicProtocol?
        weak var basePresenter: BasePresenterVIPProtocol? { return presenter }
        private var currentPage: Int = 1
        private var currentTag: String = ""
        private var isLoading = false
    }
}

// MARK: Interator Mandatory BusinessLogicProtocol

extension I.GalleryAppS1Interactor: BaseInteractorVIPMandatoryBusinessLogicProtocol {

    /// When the screen is loaded, this function is responsible to bind the View with some (temporary or final) data
    /// till the user have all the data loaded on the view. This will improve user experience.
    func requestScreenInitialState() {
        var response: VM.GalleryAppS1.ScreenInitialState.Response!
        response = VM.GalleryAppS1.ScreenInitialState.Response(photos: [])
        presenter?.presentScreenInitialState(response: response)
    }

}

// MARK: Private Stuff

private extension I.GalleryAppS1Interactor {
    func fetch(tag: String,
               page: Int,
               showSpinner: Bool,
               onSuccess: @escaping (String, [GalleryAppModel.Search.Photo]) -> Void,
               onFail: @escaping (String, [GalleryAppModel.Search.Photo]) -> Void) {
        guard let presenter = presenter,
            GalleryAppResolver.worker != nil,
            !isLoading else {
            return
        }
        isLoading = true
        currentPage = page

        // Lets turn things like 'cat, Dog', 'cat   dog ', 'Cat ; dog', 'Cat and dog' into ["cat", "dog"]
        var escaped = tag
        escaped = escaped.replacingOccurrences(of: " ", with: ",")
        escaped = escaped.replacingOccurrences(of: ";", with: ",")
        escaped = escaped.replacingOccurrences(of: "-", with: ",")
        escaped = escaped.replacingOccurrences(of: " and ", with: ",")

        let tags: [String] = escaped.components(separatedBy: ",").map({ $0.trim.lowercased() }).filter({ $0.count > 0 })

        guard tags.count > 0 else {
            isLoading = false
            onFail(tag, [])
            return
        }

        if showSpinner {
            // Turn loading on
            presenter.presentLoading(response: BaseDisplayLogicModels.Loading(isLoading: true))
        }
        let apiRequest = GalleryAppRequests.Search(tags: tags, page: currentPage)
        GalleryAppResolver.worker!.search(apiRequest, cacheStrategy: .cacheElseLoad)
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (result) in
                onSuccess(tag, result.photos.photo)
        }, onError: { [weak self] (error) in
            // Turn loading off
            self?.presentError(error: error)
            onFail("", [])
            self?.isLoading = false
        }, onCompleted: { [weak self] in
            // Turn loading off
            if showSpinner {
                self?.presenter?.presentLoading(response: BaseDisplayLogicModels.Loading(isLoading: false))
            }
            self?.isLoading = false
        }).disposed(by: disposeBag)
    }
}

// MARK: BusinessLogicProtocol

extension I.GalleryAppS1Interactor: GalleryAppS1BusinessLogicProtocol {

    func requestLoadMore(request: VM.GalleryAppS1.LoadMore.Request) {
        guard !isLoading else {
            return
        }
        currentPage += 1
        fetch(tag: currentTag, page: currentPage, showSpinner: false,
            onSuccess: { [weak self] (_, photos) in
                let response = VM.GalleryAppS1.LoadMore.Response(photos: photos)
                self?.presenter?.presentLoadMore(response: response)
            },
            onFail: { [weak self] (_, photos) in
                let response = VM.GalleryAppS1.LoadMore.Response(photos: photos)
                self?.presenter?.presentLoadMore(response: response)
        })
    }

    func requestSearchByTag(request: VM.GalleryAppS1.SearchByTag.Request) {
        currentPage = 1
        currentTag = request.tag
        fetch(tag: currentTag, page: currentPage, showSpinner: true,
            onSuccess: { [weak self] (tag, photos) in
                let response = VM.GalleryAppS1.SearchByTag.Response(searchValue: tag, photos: photos)
                self?.presenter?.presentSearchByTag(response: response)
            },
            onFail: { [weak self] (tag, photos) in
                let response = VM.GalleryAppS1.SearchByTag.Response(searchValue: tag, photos: photos)
                self?.presenter?.presentSearchByTag(response: response)
        })
    }

}

// MARK: Utils

extension I.GalleryAppS1Interactor {
    func presentError(error: Error) {
        let response = BaseDisplayLogicModels.Error(title: error.localisedMessageForView)
        basePresenter?.presentError(response: response)
    }
}
