//
//  Created by Ricardo Santos
//  Copyright (c) 2020 Ricardo P Santos. All rights reserved.
//

import UIKit
import Foundation
import SwiftUI
//
import RxCocoa
import RxSwift
import RxDataSources
import TinyConstraints
import RJSLibUFBase
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

// MARK: - Preview

@available(iOS 13.0.0, *)
struct GalleryAppS1View_UIViewRepresentable: UIViewRepresentable {
    func updateUIView(_ uiView: V.GalleryAppS1View, context: Context) { }
    func makeUIView(context: Context) -> V.GalleryAppS1View {
        let view = V.GalleryAppS1View()
        var dataSource: [VM.GalleryAppS1.TableItem] = []
        ["50270217153", "50271093502", "50271093167", "50274596092", "50273759963", "50274435276"].forEach { (some) in
            let item = VM.GalleryAppS1.TableItem(enabled: true, image: Images.noInternet.rawValue, title: some, subtitle: some, id: some)
            dataSource.append(item)
        }
        let viewModel = VM.GalleryAppS1.SearchByTag.ViewModel(searchValue: "kittie", dataSource: dataSource)
        view.setupWith(searchByTag: viewModel)
        return view
    }
}

@available(iOS 13.0.0, *)
struct GalleryAppS1View_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        GalleryAppS1View_UIViewRepresentable()
    }
}

// MARK: - View

extension V {
    public class GalleryAppS1View: BaseGenericViewVIP {

        deinit {
            DevTools.Log.logDeInit("\(self.className) was killed")
            NotificationCenter.default.removeObserver(self)
        }

        // MARK: - UI Elements (Private and lazy by default)

        private lazy var scrollView: UIScrollView = {
            UIKitFactory.scrollView()
        }()

        private lazy var stackViewVLevel1: UIStackView = {
            UIKitFactory.stackView(axis: .vertical)
        }()

        private lazy var searchBar: CustomSearchBar = {
            UIKitFactory.searchBar(placeholder: Messages.search.localised)
        }()

        private lazy var lblNoRecords: UILabel = {
            UIKitFactory.label(title: Messages.noRecords.localised, style: .value)
        }()

        private var collectionViewDataSource: [VM.GalleryAppS1.TableItem] = [] {
            didSet {
                if collectionViewDataSource.count > 0 {
                    lblNoRecords.isHidden = true
                } else {
                    lblNoRecords.isHidden = false
                }
                DevTools.Log.message("Will display \(collectionViewDataSource.count) records")
                collectionView.reloadData()
            }
        }

        // Naming convention: rxTbl[MeaningfulTableName]Items
        var rxFilter = BehaviorSubject<String?>(value: nil)
        var rxLoadMore = BehaviorSubject<Bool?>(value: nil)

        private lazy var collectionView: UICollectionView = {
             let viewLayout = UICollectionViewFlowLayout()
             viewLayout.scrollDirection = .vertical
             let some = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
             return some
         }()

        // MARK: - Mandatory

        // Order in View life-cycle : 1
        // This function is called automatically by super BaseGenericViewVIP
        // There are 3 functions specialised according to what we are doing. Please use them accordingly
        // Function 1/3 : JUST to add stuff to the view....
        public override func prepareLayoutCreateHierarchy() {
            addSubview(searchBar)
            addSubview(collectionView)
            collectionView.addSubview(lblNoRecords)
        }

        // This function is called automatically by super BaseGenericViewVIP
        // There are 3 functions specialised according to what we are doing. Please use them accordingly
        // Function 2/3 : JUST to setup layout rules zone....
        public override func prepareLayoutBySettingAutoLayoutsRules() {

            let topBarSize = TopBar.defaultHeight(usingSafeArea: false)
            searchBar.autoLayout.height(Designables.Sizes.Button.defaultSize.height)
            searchBar.autoLayout.widthToSuperview()
            searchBar.autoLayout.topToSuperview(offset: topBarSize, usingSafeArea: false)

            collectionView.autoLayout.topToBottom(of: searchBar, offset: Designables.Sizes.Margins.defaultMargin)
            collectionView.autoLayout.leadingToSuperview()
            collectionView.autoLayout.trailingToSuperview()
            collectionView.autoLayout.bottomToSuperview()

            lblNoRecords.autoLayout.width(screenWidth/2)
            lblNoRecords.autoLayout.height(screenHeight/5)
            lblNoRecords.autoLayout.center(in: collectionView)

        }

        // This function is called automatically by super BaseGenericViewVIP
        // There are 3 functions specialised according to what we are doing. Please use them accordingly
        // Function 3/3 : Stuff that is not included in [prepareLayoutCreateHierarchy] and [prepareLayoutBySettingAutoLayoutsRules]
        public override func prepareLayoutByFinishingPrepareLayout() {
            lblNoRecords.textAlignment = .center
            collectionView.register(V.CustomCollectionViewCell.self, forCellWithReuseIdentifier: V.CustomCollectionViewCell.identifier)
            collectionView.delegate = self
            collectionView.dataSource = self
        }

        public override func setupColorsAndStyles() {
            self.backgroundColor = ComponentColor.background
            lblNoRecords.font = AppFonts.Styles.headingSmall.rawValue
            lblNoRecords.textColor = ComponentColor.primary
            searchBar.backgroundColor = self.backgroundColor
            searchBar.tintColor = self.backgroundColor
            searchBar.barTintColor = self.backgroundColor
            collectionView.backgroundColor = self.backgroundColor
        }

        // Order in View life-cycle : 2
        // This function is called automatically by super BaseGenericView
        public override func setupViewUIRx() {

            searchBar.rx.text
                .orEmpty
                .skip(1)
                .debounce(.milliseconds(AppConstants.Rx.textFieldsDefaultDebounce), scheduler: MainScheduler.instance)
                .subscribe(onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.rxFilter.onNext(self.searchBar.text)
                })
                .disposed(by: disposeBag)
            
            searchBar.rx.textDidEndEditing
                .subscribe(onNext: { [weak self] (_) in
                    guard let self = self else { return }
                    guard self.searchBar.text!.count > 0 else { return }
                    self.rxFilter.onNext(self.searchBar.text)
                })
                .disposed(by: self.disposeBag)
        }

        // MARK: - Custom Getter/Setters

        func setupWith(searchByTag viewModel: VM.GalleryAppS1.SearchByTag.ViewModel) {
            collectionViewDataSource = viewModel.dataSource
        }

        func setupWith(screenInitialState viewModel: VM.GalleryAppS1.ScreenInitialState.ViewModel) {
            collectionViewDataSource = viewModel.dataSource
        }

        func setupWith(loadMore viewModel: VM.GalleryAppS1.LoadMore.ViewModel) {
            collectionViewDataSource += viewModel.dataSource
        }

    }
}

// MARK: - UICollectionViewDataSource

extension V.GalleryAppS1View: UICollectionViewDataSource {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height * 4 {
            rxLoadMore.onNext(true)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewDataSource.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = V.CustomCollectionViewCell.identifier
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? V.CustomCollectionViewCell {
            cell.setup(viewModel: collectionViewDataSource[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension V.GalleryAppS1View: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: V.CustomCollectionViewCell.defaultWidth, height: V.CustomCollectionViewCell.defaultHeight)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let defaultMargin: CGFloat = V.CustomCollectionViewCell.defaultMargin
        return UIEdgeInsets(top: defaultMargin, left: defaultMargin, bottom: defaultMargin, right: defaultMargin)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return V.CustomCollectionViewCell.defaultMargin
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0//V.CustomCollectionViewCell.defaultMargin
    }
}
