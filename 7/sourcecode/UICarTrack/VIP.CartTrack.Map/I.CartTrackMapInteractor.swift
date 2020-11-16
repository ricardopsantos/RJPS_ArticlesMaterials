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
import TinyConstraints
//
import BaseConstants
import AppTheme
import Designables
import DevTools
import BaseDomain
import DomainCarTrack
import Extensions
import PointFreeFunctions
import BaseUI
import AppResources

//
// Interactor will fetch the Domain objects, (from DataManager or WebAPI) and return that response
// to the Presenter. The Presenter will parse then into ViewModel objects
//
// The interactor contains your app’s business logic. The user taps and swipes in your UI in
// order to interact with your app. The view controller collects the user inputs from the UI
// and passes it to the interactor. It then retrieves some models and asks some workers to do the work.
//

extension I {
    class CartTrackMapInteractor: BaseInteractorVIP, CartTrackMapDataStoreProtocol {

        var presenter: CartTrackMapPresentationLogicProtocol?
        weak var basePresenter: BasePresenterVIPProtocol? { return presenter }

        var list: [CarTrackAppModel.User] = []
    }
}

// MARK: Interator Mandatory BusinessLogicProtocol

extension I.CartTrackMapInteractor: BaseInteractorVIPMandatoryBusinessLogicProtocol {

    /// When the screen is loaded, this function is responsible to bind the View with some (temporary or final) data
    /// till the user have all the data loaded on the view. This will improve user experience.
    func requestScreenInitialState() {
        let response = VM.CartTrackMap.ScreenInitialState.Response()
        presenter?.presentScreenInitialState(response: response)
    }

}

// MARK: Private Stuff

private extension I.CartTrackMapInteractor {

}

// MARK: BusinessLogicProtocol

extension I.CartTrackMapInteractor: CartTrackMapBusinessLogicProtocol {

    func requestMapDataFilter(viewModel: VM.CartTrackMap.MapDataFilter.Request) {
        if viewModel.filter.count > 0 {
            let filtered = self.list.filter { (some) -> Bool in
                let c1 = some.company.name.contains(subString: viewModel.filter)
                let c2 = some.name.contains(subString: viewModel.filter)
                return c1 || c2
            }
            let response = VM.CartTrackMap.MapData.Response(list: filtered)
            self.presenter?.presentMapData(response: response)
        } else if list.count > 0 {
            let response = VM.CartTrackMap.MapData.Response(list: list)
            self.presenter?.presentMapData(response: response)
        }
    }

    func requestMapData(request: VM.CartTrackMap.MapData.Request) {
        presenter?.presentLoading(response: BaseDisplayLogicModels.Loading(isLoading: true))
        CarTrackResolver.worker?.getUsers(request: CarTrackRequests.GetUsers(userName: ""), cacheStrategy: .cacheElseLoad)
            .asObservable()
            .subscribe(onNext: { [weak self] (result) in
                guard let self = self else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.list = result.compactMap({ $0.toDomain })
                    let response = VM.CartTrackMap.MapData.Response(list: self.list)
                    self.presenter?.presentMapData(response: response)
                }
            }, onError: { (error) in
                DevTools.Log.error(error)
                self.presentError(error: error)
                self.presenter?.presentLoading(response: BaseDisplayLogicModels.Loading(isLoading: false))
            }, onCompleted: {
                self.presenter?.presentLoading(response: BaseDisplayLogicModels.Loading(isLoading: false))
            }).disposed(by: disposeBag)
    }

}

// MARK: Utils {

extension I.CartTrackMapInteractor {
    func presentError(error: Error) {
        let response = BaseDisplayLogicModels.Error(title: error.localisedMessageForView)
        basePresenter?.presentError(response: response)
    }
}
