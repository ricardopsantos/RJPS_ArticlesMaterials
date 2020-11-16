//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright (c) 2020 Ricardo P Santos. All rights reserved.
//
import Foundation
import UIKit
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
import AppResources
import BaseUI

//
// After the interactor produces some results, it passes the response to the presenter.
// The presenter then marshal the response into view models suitable for display.
// It then passes the view models back to the view controller for display to the user.
//
// Now that we have the Response from the Interactor, it’s time to format it
// into a ViewModel and pass the result back to the ViewController. Presenter will be
// in charge of the presentation logic. This component decides how the data will be presented to the user.
//

extension P {
    class CartTrackMapPresenter: BasePresenterVIP {
        weak var viewController: (CartTrackMapDisplayLogicProtocol)?

        override weak var baseViewController: BaseViewControllerVIPProtocol? {
            return viewController
        }
    }
}

// MARK: PresentationLogicProtocol

extension P.CartTrackMapPresenter {

}

// MARK: PresentationLogicProtocol

extension P.CartTrackMapPresenter: CartTrackMapPresentationLogicProtocol {

    private func buildReport(list: [CarTrackAppModel.User]) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        let date = formatter.string(from: Date())

        var report = ""
        var i = 1
        if list.count == 0 {
            report = "\(date)\n\n\(Messages.noRecords.localised.uppercased())"
        } else {
            report = "\(date)\n"
            list.forEach { (some) in
                report = "\(report)\n\(i). \(some.company.name)"
                i += 1
            }
        }
        return report
    }
    // Used By Interactor (exclusively)
    func presentScreenInitialState(response: VM.CartTrackMap.ScreenInitialState.Response) {
        let viewModel = VM.CartTrackMap.ScreenInitialState.ViewModel()
        viewController?.displayScreenInitialState(viewModel: viewModel)
    }

    // Used By Interactor (exclusively)
    func presentMapData(response: VM.CartTrackMap.MapData.Response) {
        let report    = buildReport(list: response.list)
        let viewModel = VM.CartTrackMap.MapData.ViewModel(report: report, list: response.list)
        viewController?.displayMapData(viewModel: viewModel)
    }

    // Used By Interactor (exclusively)
    func presentMapDataFilter(response: VM.CartTrackMap.MapDataFilter.Response) {
        let report    = buildReport(list: response.list)
        let viewModel = VM.CartTrackMap.MapDataFilter.ViewModel(report: report, list: response.list)
        viewController?.displayMapDataFilter(viewModel: viewModel)
    }

}
