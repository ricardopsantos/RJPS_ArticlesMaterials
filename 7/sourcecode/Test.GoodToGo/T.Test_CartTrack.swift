//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import XCTest
import RxSwift

@testable import GoodToGo
//
@testable import Core
@testable import Core_CarTrack
//
@testable import Domain
@testable import Domain_CarTrack

class Test_CartTrack: XCTestCase {

    let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_resolvers() {
       // XCTAssert(GoodToGo.CarTrackResolver.shared.api != nil)
       // XCTAssert(GoodToGo.CarTrackResolver.shared.genericBusiness != nil)
    }

    func test_vc_mapWithData() {
        let expectation = self.expectation(description: #function)
        let vc = GoodToGo.VC.CartTrackMapViewController()
        let request = GoodToGo.VM.CartTrackMap.MapData.Request()
        vc.interactor?.requestMapData(request: request)

        DispatchQueue.main.asyncAfter(deadline: .now() + TestsShared.shared.waitForExpectationsDefaultTime - 1, execute: {
            XCTAssert(vc.genericView.mapView.annotations.count > 0)
            expectation.fulfill()
        })

        waitForExpectations(timeout: TestsShared.shared.waitForExpectationsDefaultTime)
    }
/*
    func test_api_getUserDetailV1() {
        let expectation = self.expectation(description: #function)
        GoodToGo.CarTrackResolver.shared.api?.getUserDetailV1(completionHandler: { (result) in
            switch result {
            case .success: XCTAssert(true)
            case .failure: XCTAssert(false)
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: TestsShared.shared.waitForExpectationsDefaultTime)
    }

    func test_api_getUserDetailV3() {
        let expectation = self.expectation(description: #function)
        GoodToGo.CarTrackResolver.shared.api?.getUserDetailV3(cacheStrategy: .cacheAndLoad)
            .asObservable().subscribe(onNext: { (result) in
                switch result {
                case .success: XCTAssert(true)
                case .failure: XCTAssert(false)
                }
                expectation.fulfill()
            }).disposed(by: disposeBag)
        waitForExpectations(timeout: TestsShared.shared.waitForExpectationsDefaultTime)
    }
*/
    func test_genericBusiness_validateUserAndPassword1() {
     /*   let expectation = self.expectation(description: #function)
        GoodToGo.CarTrackResolver.shared.genericBusiness?.validate(user: "", password: "12345", completionHandler: { (result) in
            switch result {
            case .success: XCTAssert(true)
            case .failure: XCTAssert(false)
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: TestsShared.shared.waitForExpectationsDefaultTime)*/
    }

    func test_genericBusiness_validateUserAndPassword2() {
     /*   let expectation = self.expectation(description: #function)
        GoodToGo.CarTrackResolver.shared.genericBusiness?.validate(user: "", password: "wrong password", completionHandler: { (result) in
            switch result {
            case .success: XCTAssert(false)
            case .failure(let error): XCTAssert(error.appCode == AppCodes.invalidCredentials)
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: TestsShared.shared.waitForExpectationsDefaultTime)*/
    }
}
